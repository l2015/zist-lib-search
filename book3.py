import requests
from bs4 import BeautifulSoup
from PIL import Image, ImageDraw, ImageFont
import datetime


def search_book():
    keyword = input('请输入关键字：')
    encodedKeyword = keyword.encode('utf-8')
    url = 'https://afd.zykj.edu.cn/opac/booklist.jsp'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/111.0.0.0 Safari/537.36',
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    data = {
        'bibindex': 'keyword',
        'keyword': encodedKeyword,
        'searchtype': 'keyword',
        'searchkey': encodedKeyword,
        'resulttype': '',
        'resultkey': '',
        'page': '',
        'pagesize': '',
        'libcode': '',
        'location': '',
        'sysid': '',
        'author': '',
        'publish': '',
        'year': '',
        'endyear': '',
        'classnosub': '',
        'subject': '',
        'solrfield': '',
        'solrsort': ''
    }
    response = requests.post(url, headers=headers, data=data)
    soup = BeautifulSoup(response.text, 'html.parser')
    bookFlds = soup.select('.book-fld')
    bookList = []
    for i, bookFld in enumerate(bookFlds):
        title = bookFld.select_one('.fld-title a')
        if title is not None:
            title = title.text.strip()
        author = bookFld.select_one('.div-info-fld span:first-child')
        if author is not None:
            author = author.text.strip().replace('作者：', '')
        source = bookFld.select('.div-info-fld')[1].select_one('span:first-child')
        if source is not None:
            source = source.text.strip().replace('出处：', '')
        isbn = bookFld.select_one('.div-info-fld span:nth-child(2)')
        if isbn is not None:
            isbn = isbn.text.strip().replace('ISBN：', '')
        holdingListBtn = bookFld.select_one('.show-hld-list')
        bibid = holdingListBtn.get('id') if holdingListBtn is not None else None
        url = 'https://afd.zykj.edu.cn/opac/hld/holding/getHoldings.do'
        headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/111.0.0.0 Safari/537.36',
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        data = {
            'bibid': bibid
        } if bibid is not None else {}
        response = requests.post(url, headers=headers, data=data)
        holdingData = response.json() if bibid is not None else []

        holdingDict = {}
        for holding in holdingData:
            if holding['libcode'] not in holdingDict:
                holdingDict[holding['libcode']] = {}
            if holding['status'] not in holdingDict[holding['libcode']]:
                holdingDict[holding['libcode']][holding['status']] = {'count': 0, 'barcodes': [], 'callNumber': []}
            holdingDict[holding['libcode']][holding['status']]['count'] += 1
            holdingDict[holding['libcode']][holding['status']]['barcodes'].append(holding['barcode'])
            if holding['callno'] not in holdingDict[holding['libcode']][holding['status']]['callNumber']:
                holdingDict[holding['libcode']][holding['status']]['callNumber'].append(holding['callno'])

        bookList.append({
            'Title': title,
            'Author': author,
            'Source': source,
            'ISBN': isbn,
            'Holding List': holdingDict
        })
        print(f'{i + 1}. {title} 作者：{author} \n 出处： {source} ISBN： {isbn}')
    selectedBookIndex = int(input('请选择书目：')) - 1
    selectedBook = bookList[selectedBookIndex]
    print(f'Title: {selectedBook["Title"]}')
    print(f'Author: {selectedBook["Author"]}')
    print(f'Source: {selectedBook["Source"]}')
    print(f'ISBN: {selectedBook["ISBN"]}')
    print('Holding List:')
    for i, (location, statusDict) in enumerate(selectedBook['Holding List'].items()):
        print(f'{i + 1}. 位置: {location}')
        for status, barcodeDict in statusDict.items():
            print(f'索书号: {", ".join(barcodeDict["callNumber"])}')
            print(f'状态: {status}: {barcodeDict["count"]} 本')
            print(f'条码: {", ".join(barcodeDict["barcodes"])}')
        print('------------------------')
    return selectedBook


def store_book(selectedBook):
    # store selected book information
    with open('book_info.txt', 'a') as f:
        f.write(f'Title: {selectedBook["Title"]}\n')
        f.write(f'Author: {selectedBook["Author"]}\n')
        f.write(f'Source: {selectedBook["Source"]}\n')
        f.write(f'ISBN: {selectedBook["ISBN"]}\n')
        f.write('Holding List:\n')
        for i, (location, statusDict) in enumerate(selectedBook['Holding List'].items()):
            f.write(f'{i + 1}. 位置: {location}\n')
            for status, barcodeDict in statusDict.items():
                f.write(f'索书号: {", ".join(barcodeDict["callNumber"])}\n')
                f.write(f'状态: {status}: {barcodeDict["count"]} 本\n')
                f.write(f'条码: {", ".join(barcodeDict["barcodes"])}\n')
            f.write('------------------------\n')


def continue_search():
    pass


def output_image():
    # 读取书籍信息
    with open('book_info.txt', 'r') as f:
        book_info = f.readlines()

    # 计算图片尺寸
    font_path = "/System/Library/Fonts/STHeiti Light.ttc"
    font_size = 20
    line_spacing = font_size + 10
    img_width = 700
    img_height = (line_spacing * len(book_info)) + (2 * line_spacing)

    # 创建图片对象
    img = Image.new('RGB', (img_width, img_height), color=(255, 255, 255))

    # 定义字体和字号
    font_path = "/System/Library/Fonts/STHeiti Light.ttc"
    font_size = 20
    font = ImageFont.truetype(font_path, font_size)

    # 创建画笔对象
    draw = ImageDraw.Draw(img)

    # 设置边距和行距
    margin = 10
    line_spacing = font_size + 10

    # 循环遍历书籍信息，绘制文本
    y = margin
    for line in book_info:
        draw.text((margin, y), line.strip(), font=font, fill=(0, 0, 0))
        y += line_spacing

    # 保存图片并显示
    now = datetime.datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    img.save(f'img/book_info_{now}.png')
    img.show()


while True:

    selected_option = input('请输入关键字：1.搜索书目 2.退出 3.将储存的条目以图片输出\n')
    if selected_option == '1':
        selectedBook = search_book()
        selected_option = input('请选择操作：1.储存条目 2.继续搜索\n')
        if selected_option == '1':
            store_book(selectedBook)
            print('已储存书目信息。')
        elif selected_option == '2':
            continue_search()
        else:
            print('无效的选项，请重新选择。')
    elif selected_option == '2':
        break
    elif selected_option == '3':
        output_image()
    else:
        print('无效的选项，请重新选择。')
