// ==UserScript==



// @name         Show Library Holdings on Douban Book Page
// @namespace    http://tampermonkey
// @version      1
// @description  Show library holdings on Douban book page
// @match        https://book.douban.com/subject/*
// @grant        GM_xmlhttpRequest
// @connect      *
// ==/UserScript==

function getBookFlds() {

    const title = document.querySelector('h1 span')?.textContent?.trim();
    GM_xmlhttpRequest({
        method: 'POST',
        url: 'http://afd.zykj.edu.cn/opac/booklist.jsp',
        headers: {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: `bibindex=keyword&keyword=${encodeURIComponent(title)}&searchtype=keyword&searchkey=${encodeURIComponent(title)}&resulttype=&resultkey=&page=&pagesize=&libcode=&location=&sysid=&author=&publish=&year=&endyear=&classnosub=&subject=&solrfield=&solrsort=`,
        onload: function (response) {
									
										console.log('调用成功0');
										console.log(`Encoded Title: ${encodeURIComponent(title)}`);

            const parser = new DOMParser();
            const htmlDoc = parser.parseFromString(response.responseText, 'text/html');
            const bookFlds = htmlDoc.querySelectorAll('.book-fld');
												console.log(bookFlds);

										  
            bookFlds.forEach(bookFld => {
                const source = bookFld.querySelector('.div-info-fld span:nth-child(2)')?.textContent?.trim()?.replace('出处：', '');
                const holdingListBtn = bookFld.querySelector('.show-hld-list');
                const bibid = holdingListBtn?.getAttribute('id');
																console.log(`bibid: ${bibid}`);
                getHoldings(bibid);


            });
        },
        onerror: function (error) {
            console.error(error);
        }
    });



			
}

function getHoldings(bibid) {
		console.log('调用成功1');
    GM_xmlhttpRequest({
        method: 'POST',
        url: 'http://afd.zykj.edu.cn/opac/hld/holding/getHoldings.do',
        headers: {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: `bibid=${bibid}`,
        onload: function (response) {
            console.log(`Title: ${title}`);
            console.log(`Author: ${author}`);
            console.log(`Source: ${source}`);
            console.log(`ISBN: ${isbn}`);
            console.log(`Series Name: ${seriesName}`);
            console.log('Holding List:');
            const holdingList = document.createElement('div');
            holdingList.style.marginTop = '20px';
            holdingList.style.borderTop = '1px solid #ccc';
            holdingList.style.paddingTop = '20px';
            holdingList.style.fontSize = '14px';
            holdingList.style.color = '#666';
            holdingList.innerHTML = '<h2 style="font-size: 16px; font-weight: bold;">Library Holdings</h2>';
            const data = JSON.parse(response.responseText);
            data.forEach(holding => {
                const holdingItem = document.createElement('div');
                holdingItem.style.marginTop = '10px';
                holdingItem.innerHTML = `
                        <div><span style="font-weight: bold;">Location:</span> ${holding.libcode}</div>
                        <div><span style="font-weight: bold;">Status:</span> ${holding.status}</div>
                        <div><span style="font-weight: bold;">Call Number:</span> ${holding.callno}</div>
                        <div><span style="font-weight: bold;">Barcode:</span> ${holding.barcode}</div>
                    `;
                holdingList.appendChild(holdingItem);
            });
            const sourceDiv = bookFld.querySelector('.div-info-fld span:nth-child(2)');
            sourceDiv.parentNode.insertBefore(holdingList, sourceDiv.nextSibling);
        },
        onerror: function (error) {
            console.error(error);
        }
    });
	console.log('调用成功');
	

}

(function () {
    'use strict';
    const title = document.querySelector('h1 span')?.textContent?.trim();
    const author = document.querySelector('.article div:nth-child(2) span:nth-child(2) a')?.textContent?.trim();
    const isbn = document.querySelector('.article div:nth-child(2) span:nth-child(4)')?.textContent?.trim()?.replace('ISBN:', '');
    const seriesName = document.querySelector('.article div:nth-child(2) span:nth-child(6)')?.textContent?.trim()?.replace('丛书:', '');
    console.log(title)
    getBookFlds();
})();
