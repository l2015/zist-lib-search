import requests




from bs4 import BeautifulSoup

keyword = input('请输入关键字：')
encodedKeyword = keyword.encode('utf-8')
url = 'http://afd.zykj.edu.cn/opac/booklist.jsp'
headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
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
    url = 'http://afd.zykj.edu.cn/opac/hld/holding/getHoldings.do'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
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
    print(f'{i+1}. {title} 作者：{author} \n 出处： {source} ISBN： {isbn}')
selectedBookIndex = int(input('请选择书目：')) - 1
selectedBook = bookList[selectedBookIndex]
print(f'Title: {selectedBook["Title"]}')
print(f'Author: {selectedBook["Author"]}')
print(f'Source: {selectedBook["Source"]}')
print(f'ISBN: {selectedBook["ISBN"]}')
print('Holding List:')
for i, (location, statusDict) in enumerate(selectedBook['Holding List'].items()):
    print(f'{i+1}. 位置: {location}')
    for status, barcodeDict in statusDict.items():
        print(f'索书号: {", ".join(barcodeDict["callNumber"])}')
        print(f'状态: {status}: {barcodeDict["count"]} 本')
        print(f'条码: {", ".join(barcodeDict["barcodes"])}')
    print('------------------------')
