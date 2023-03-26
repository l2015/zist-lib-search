const keyword = prompt('请输入关键字：');

const encodedKeyword = encodeURIComponent(keyword);
fetch('http://afd.zykj.edu.cn/opac/booklist.jsp', {
  method: 'POST',
  headers: {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  body: `bibindex=keyword&keyword=${encodedKeyword}&searchtype=keyword&searchkey=${encodedKeyword}&resulttype=&resultkey=&page=&pagesize=&libcode=&location=&sysid=&author=&publish=&year=&endyear=&classnosub=&subject=&solrfield=&solrsort=`
})
  .then(response => response.text())
  .then(data => {
    const parser = new DOMParser();
    const htmlDoc = parser.parseFromString(data, 'text/html');
    const bookFlds = htmlDoc.querySelectorAll('.book-fld');
    bookFlds.forEach(bookFld => {
      const title = bookFld.querySelector('.fld-title a')?.textContent?.trim();
      const author = bookFld.querySelector('.div-info-fld span:first-child')?.textContent?.trim()?.replace('作者：', '');
      const source = bookFld.querySelector('.div-info-fld span:nth-child(2)')?.textContent?.trim()?.replace('出处：', '');
      const isbn = bookFld.querySelector('.div-info-fld span:nth-child(3)')?.textContent?.trim()?.replace('ISBN：', '');
      const seriesName = bookFld.querySelector('.div-info-fld span:nth-child(4)')?.textContent?.trim()?.replace('丛书名：', '');
      const holdingListBtn = bookFld.querySelector('.show-hld-list');
      const bibid = holdingListBtn?.getAttribute('id');
      fetch('http://afd.zykj.edu.cn/opac/hld/holding/getHoldings.do', {
        method: 'POST',
        headers: {
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `bibid=${bibid}`
      })
        .then(response => response.json())
        .then(data => {
          console.log(`Title: ${title}`);
          console.log(`Author: ${author}`);
          console.log(`Source: ${source}`);
          console.log(`ISBN: ${isbn}`);
          console.log(`Series Name: ${seriesName}`);
          console.log('Holding List:');
          data.forEach(holding => {
            console.log(`Location: ${holding.libcode}`);
            console.log(`Status: ${holding.status}`);
            console.log(`Call Number: ${holding.callno}`);
            console.log(`Barcode: ${holding.barcode}`);
            console.log('------------------------');
          });
        })
        .catch(error => console.error(error));
    });
  })
  .catch(error => console.error(error));
