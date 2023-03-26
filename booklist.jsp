






<!DOCTYPE html>
<html>
<head>
<title item-i18n="text"  lang-msg='bl_title'>书目列表</title>
<link rel="stylesheet" href="/opac/third-party/jquery.autocomplete-1.1.3/styles.css"/> 



<link rel="stylesheet" href="/opac/css/jishen.css?version=2021-08-06"/>
<link rel="icon" href="/opac/images/favicon.ico" type="image/x-icon" />
  
<link rel="stylesheet" type="text/css"
	href="/opac/third-party/font-awesome-4.7.0/css/font-awesome.min.css">

</head>
<body>
  <!-- 功能菜单 -->
  

<script type="text/javascript" src="/opac/js/imgUitl.js?version=2021-08-06"></script>
		<div class="head-v3">
			<div class="navigation-up">
				<div class="navigation-inner">
					<div class="navigation-v3">
						<ul>
							<li class="nav-up-selected-inpage">
								<h2>
								  
									<a item-i18n="text" lang-msg='menu_home' href="/opac">首&nbsp;页</a>
								</h2>
							</li>
							<li class="" >
			
								<h2>
									<a item-i18n="text" lang-msg='menu_class' href="/opac/classretrieval.jsp?target=1">分类检索</a>
								</h2>
							</li> 
							<li class="" >
								<h2>
									<a item-i18n="text" lang-msg='menu_newbook' href="/opac/newbooklist.jsp?target=2">新书检索</a>
								
								</h2>
							</li> 
							
							
							
							   <li class="" >
									<h2>
										<a item-i18n="text" lang-msg='menu_bookloantop' href="/opac/booktoplist.jsp?target=3">文献借阅排行</a>
									</h2>
								</li> 
							
							
							
							   <li class="" >
								<h2>
									<a item-i18n="text" lang-msg='menu_bookretrunnotice' href="/opac/bookretrunnotice.jsp?target=4">图书催还通知</a>
								</h2>
						    	</li>
							
							
							
							   <li class="" >
								<h2>
									<a item-i18n="text" lang-msg='menu_appservice' href="/opac/page/book/appservice.jsp?target=5">第三方应用服务</a>
								</h2>
						    	</li>
							
							
				
						</ul>
					</div>
					
					<div class="my-menu ">
				         <div  class="lang-box">
						     <select item-i18n="select" id="lang">
						  		<option value="zh">中文</option>
						  		<option value="en">English</option>
					        </select>
				         </div>
					
						<div class=" menumylib">
							<h2 >
							  
							    <a item-i18n="text" lang-msg='menu_mylib' href="/opac/page/reader/login.jsp?target=999">我的图书馆</a>
							  
							
							  
								
							</h2>
						</div>
					
					</div>
				</div>
			</div>
<!-- 			<div class="navigation-down">
				<div id="solution" class="nav-down-menu menu-3 menu-1"
					style="display: none;" _t_nav="solution">
					<div class="navigation-down-inner">
						<dl>
							<dd>
								<a class="link"  href="#">书目检索</a>
							</dd>
						</dl>
					</div>
				</div>
			</div> -->
		</div>
 <!-- 二级菜单
   $(function(){
	    var qcloud={};
		$('[_t_nav]').hover(function(){
			var _nav = $(this).attr('_t_nav');
			clearTimeout( qcloud[ _nav + '_timer' ] );
			qcloud[ _nav + '_timer' ] = setTimeout(function(){
			$('[_t_nav]').each(function(){
			$(this)[ _nav == $(this).attr('_t_nav') ? 'addClass':'removeClass' ]('nav-up-selected');
			});
			$('#'+_nav).stop(true,true).slideDown(200);
			}, 150);
		},function(){
			var _nav = $(this).attr('_t_nav');
			clearTimeout( qcloud[ _nav + '_timer' ] );
			qcloud[ _nav + '_timer' ] = setTimeout(function(){
			$('[_t_nav]').removeClass('nav-up-selected');
			$('#'+_nav).stop(true,true).slideUp(200);
			}, 150);
		});
  }); --> 
  
  <!-- 检索区域 -->
  <div class="booklist-box">
     <!--检索分页工具条  -->
       <form  id="formbook" action="booklist.jsp"  method="post" onsubmit="return search()">
        <div class="booklist-box-page">
            
            <div class="book-search">
               <select id="bibindex" name="bibindex" item-i18n="select" class="input-keyword">
                    <option value="keyword" selected="selected">任意词</option>
					<option value="title">书名</option>
					<option value="author">作者</option>
					<option value="isbn">ISBN/ISSN</option>
					<option value="subject">主题词</option>
					<option value="seriesname">丛书名</option>
					<option value="classno">分类号</option>
					<option value="callno">索书号</option>
					<option value="publish">出版社</option>
					<option value="publishdate">出版年</option>
               </select>
               <input id="keyword" name="keyword" class="input-keyword" item-i18n="placeholder"  lang-msg='idx_sh_tip'  value="东野圭吾" placeholder="请输入您要检索的内容">
               <input type="submit" value="重新检索" item-i18n="value"  lang-msg='bl_sh_repeat'  class="serarh-bnt" >
               <input type="button" value="结果中检索" item-i18n="value"  lang-msg='bl_sh_result' class="serarh-bnt" onclick="searchAgain()">
               <input type="button"  value="高级检索" item-i18n="value"  lang-msg='bl_sh_vip' class="serarh-bnt" onclick="advancedSearch()">
               
               
            </div>
         
           
        </div>
        
        <div class="spell-box">
        
       </div>
        
           <div style="display: none;">
               <input type="text" id="searchtype"   name="searchtype" value="keyword" >
               <input type="text" id="searchkey"    name="searchkey" value="东野圭吾" >
               <input type="text" id="resulttype"   name="resulttype" value="" class="solr-condition ">
               <input type="text" id="resultkey"    name="resultkey" value="" class="solr-condition">
               <input type="text" id="page"         name="page" value="1" class="solr-condition">
               <input type="text" id="pagesize"     name="pagesize" value="10" class="solr-condition">
               <input type="text" id="libcode"     name="libcode" value="" class="solr-condition facet-condtion">
               <input type="text" id="location"     name="location" value="" class="solr-condition facet-condtion">
               <input type="text" id="sysid"     name="sysid" value="" class="solr-condition facet-condtion">
               <input type="text" id="author"     name="author" value="" class="solr-condition facet-condtion">
               <input type="text" id="publish"     name="publish" value="" class="solr-condition facet-condtion">
               <input type="text" id="year"     name="year" value="" class="solr-condition facet-condtion">
               <input type="text" id="endyear"     name="endyear" value="" class="solr-condition facet-condtion">
               <input type="text" id="classnosub"     name="classnosub" value="" class="solr-condition facet-condtion">
               <input type="text" id="subject"     name="subject" value="" class="solr-condition facet-condtion">
               <input type="text" id="solrfield"     name="solrfield" value="score" class="solr-condition ">
               <input type="text" id="solrsort"     name="solrsort" value="desc" class="solr-condition ">
               <input type="text" id="foundnum" value="66">
               <input type="text" id="qtime" value="2">
            </div>
         </form>
         
 
        <div class="chart-year"  id="echartBox" style="width: 1180px;height: 300px;border: 1px solid #e8e8e8;margin-bottom: 10px;display: none;">
        
        
        </div>
        
        <div class="search-info">
           <div style="float:left;width: 930px;padding: 0px 10px">
           <a  href="http://baike.baidu.com/search?word=东野圭吾&pn=0&rn=0&enc=utf8"   title="百度百科词条"><span style="color: #ff5e0f;">东野圭吾</span></a>
             <span style="color: #ff5e0f;"></span>                          
              <label item-i18n="html" lang-msg='bl_result_tip' lang-param='foundnum,qtime'>共有66条记录，耗时[2]毫秒</label>
           </div>
           
           <div style="float: right;width: 220px;">
                 <label item-i18n="html"  lang-msg='bl_sort_key'>排序选项</label>
                 <select id="sortkey" item-i18n="select" onchange="sortBookList()" class="input-keyword" style="margin-top: -6px;width: 80px;">
				    <option value="score" selected="selected">相似度</option>
					<option value="title">书名</option>
					<option value="author">作者</option>
					<option value="isbn">ISBN/ISSN</option>
					<option value="subject">主题词</option>
					<option value="seriesname">丛书名</option>
					<option value="classno">分类号</option>
					<option value="callno">索书号</option>
					<option value="publish">出版社</option>
					<option value="year">出版年</option>
               </select>
               <select id="sorttype" item-i18n="select" onchange="sortBookList()" class="input-keyword"  style="margin-top: -6px;width: 80px;">
				    <option value="asc" >升序</option>
					<option value="desc" selected="selected">降序</option>
               </select>
           </div>
        </div>
        <div class="search-facet" style="clear: both;">
           
        </div>
        <div class="booklist-box-left">
           <h3 class="facet_title hotSearchKey" item-i18n="html"  lang-msg='bl_hot_word'>热门检索词</h3>
           <div id="tagbox" class="hotSearchKey">
          </div>
           
           <h3 class="facet_title" item-i18n="html"  lang-msg='bl_facet'>分类筛选</h3>
           <dl class="sidelist  sidelist-dt">
					    <dt >
					
							<span class="title"><span item-i18n="html"  lang-msg='bl_facet_btype'>文献类型</span></span>
						
						</dt> 
						<dd>
					         <ul class="text-list">
					            
							    <li><a href="JavaScript:facetSearch('sysid','0')">图书(66)</a></li>
			                    
					         </ul>
						</dd>
						
						<dt class="tu-shu-fen-bu">
							<span class="title"><span item-i18n="html"  lang-msg='bl_facet_lib'>图书分布</span></span>
						</dt> 
						<dd class="tu-shu-fen-bu">
						    <ul class="text-list">
					            
							    <li><a href="JavaScript:facetSearch('libcode','001')">中原科技学院图书馆(65)</a></li>
			                    
							    <li><a href="JavaScript:facetSearch('libcode','002')">中原科技学院图书馆(许昌)(20)</a></li>
			                    
					         </ul>
						</dd>
						
						<dt class="item">
					
							<span class="title"><span item-i18n="html"  lang-msg='bl_facet_location'>图书所在地</span>
								
								</span>
								
								 
						</dt> 
						<dd>
						    <ul class="text-list">
					            
							    <li><a href="JavaScript:facetSearch('location','ZWSK')">中文书库(59)</a></li>
			                    
							    <li><a href="JavaScript:facetSearch('location','YBSK')">样本书库(36)</a></li>
			                    
							    <li><a href="JavaScript:facetSearch('location','0006')">立身书库(20)</a></li>
			                    
							    <li><a href="JavaScript:facetSearch('location','0003')">新书书库(3)</a></li>
			                    
					         </ul>
						</dd>
						
					
							<dt class="item">
								<span class="title"><span item-i18n="html"  lang-msg='bl_facet_author'>作者</span>
								
								(+)
								
								</span>
								
								 
								    <span class="show-all-data">
										<div class="subitem">
										<div class="inner">
											<div class="tit tit1">
												<div class="name"><span item-i18n="html"  lang-msg='bl_facet_author'>作者</span></div>
												<ul>
												  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；袁斌译')">(日)东野圭吾著；袁斌译(10)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；王蕴洁译')">(日)东野圭吾著；王蕴洁译(7)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；袁斌译')">(日) 东野圭吾著；袁斌译(3)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；刘姿君译')">(日)东野圭吾著；刘姿君译(3)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；徐建雄译')">(日)东野圭吾著；徐建雄译(3)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；李炜译')">(日)东野圭吾著；李炜译(3)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；李盈春译')">(日)东野圭吾著；李盈春译(3)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾[著]；魏精彩译')">(日)东野圭吾[著]；魏精彩译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；刘子倩译')">(日)东野圭吾著；刘子倩译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；娄美莲译')">(日)东野圭吾著；娄美莲译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；岳远坤译')">(日)东野圭吾著；岳远坤译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；朱田云译')">(日)东野圭吾著；朱田云译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；李超楠译')">(日)东野圭吾著；李超楠译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；杨婉蘅译')">(日)东野圭吾著；杨婉蘅译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；王维幸译')">(日)东野圭吾著；王维幸译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；连子心译')">(日)东野圭吾著；连子心译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；陈文娟译')">(日)东野圭吾著；陈文娟译(2)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；代珂译')">(日) 东野圭吾著；代珂译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；刘子倩译')">(日) 东野圭吾著；刘子倩译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；匡匡译')">(日) 东野圭吾著；匡匡译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；尹月译')">(日) 东野圭吾著；尹月译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；星野空译')">(日) 东野圭吾著；星野空译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；赵峻译')">(日) 东野圭吾著；赵峻译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；陈祖懿译')">(日) 东野圭吾著；陈祖懿译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾；袁斌译')">(日) 东野圭吾；袁斌译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾；赵文梅译')">(日) 东野圭吾；赵文梅译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；宋扬译')">(日)东野圭吾著；宋扬译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；星野空译')">(日)东野圭吾著；星野空译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；赵峻译')">(日)东野圭吾著；赵峻译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；陈祖懿译')">(日)东野圭吾著；陈祖懿译(1)</a></li>
								                  
								                     <li><a href="JavaScript:facetSearch('author','(日本) 东野圭吾著；袁斌译')">(日本) 东野圭吾著；袁斌译(1)</a></li>
								                  
												</ul>
											</div>
										</div>
									 </div>
									</span>
								 
							
						</dt> 
						<dd>
						    <ul class="text-list">
					            
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；袁斌译')">(日)东野圭吾著；袁斌译(10)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；王蕴洁译')">(日)东野圭吾著；王蕴洁译(7)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日) 东野圭吾著；袁斌译')">(日) 东野圭吾著；袁斌译(3)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；刘姿君译')">(日)东野圭吾著；刘姿君译(3)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；徐建雄译')">(日)东野圭吾著；徐建雄译(3)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；李炜译')">(日)东野圭吾著；李炜译(3)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；李盈春译')">(日)东野圭吾著；李盈春译(3)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾[著]；魏精彩译')">(日)东野圭吾[著]；魏精彩译(2)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；刘子倩译')">(日)东野圭吾著；刘子倩译(2)</a></li>
								   
							    
			                    
					             
								       <li><a href="JavaScript:facetSearch('author','(日)东野圭吾著；娄美莲译')">(日)东野圭吾著；娄美莲译(2)</a></li>
								   
							    
			                    
			                 
					         </ul>
					        
						</dd>

					
						<dt class="item">
								<span class="title"><span item-i18n="html"  lang-msg='bl_facet_publish'>出版社</span>
								
								(+)
								
								</span>
								
								 
								    <span class="show-all-data">
										<div class="subitem">
										<div class="inner">
											<div class="tit tit1">
												<div class="name"><span item-i18n="html"  lang-msg='bl_facet_publish'>出版社</span></div>
												<ul>
												  
								                    <li><a href="JavaScript:facetSearch('publish','南海出版公司')">南海出版公司(32)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','人民文学出版社')">人民文学出版社(9)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','北京联合出版公司')">北京联合出版公司(7)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','北京十月文艺出版社')">北京十月文艺出版社(6)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','化学工业出版社')">化学工业出版社(3)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','现代出版社')">现代出版社(3)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','华文出版社')">华文出版社(2)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','上海译文出版社')">上海译文出版社(1)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','当代世界出版社')">当代世界出版社(1)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','湖南文艺出版社')">湖南文艺出版社(1)</a></li>
								                  
								                    <li><a href="JavaScript:facetSearch('publish','译林出版社')">译林出版社(1)</a></li>
								                  
												</ul>
											</div>
										</div>
									 </div>
									</span>
								 
							
						</dt>
						<dd>
						    <ul class="text-list">
					            
							   
								    <li><a href="JavaScript:facetSearch('publish','南海出版公司')">南海出版公司(32)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','人民文学出版社')">人民文学出版社(9)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','北京联合出版公司')">北京联合出版公司(7)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','北京十月文艺出版社')">北京十月文艺出版社(6)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','化学工业出版社')">化学工业出版社(3)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','现代出版社')">现代出版社(3)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','华文出版社')">华文出版社(2)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','上海译文出版社')">上海译文出版社(1)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','当代世界出版社')">当代世界出版社(1)</a></li>
								
			                    
							   
								    <li><a href="JavaScript:facetSearch('publish','湖南文艺出版社')">湖南文艺出版社(1)</a></li>
								
			                    
			                   
							</ul>	 
						</dd> 
						<dt class="item">
								<span class="title"><span item-i18n="html"  lang-msg='bl_facet_class'>分类号</span>
								
								</span>
								
								 
							
						</dt> 
						<dd>
						    <ul class="text-list">
					            
							
								    <li><a href="JavaScript:facetSearch('classnosub','I')">I 文学(66)</a></li>
							
			                    
			                   
							</ul>	 
						</dd>
						<dt class="item">
					
								<span class="title"><span item-i18n="html"  lang-msg='bl_facet_year'>出版年</span>
								
								(+)
								
								</span>
								
								 
								    <span class="show-all-data">
										<div class="subitem">
										<div class="inner">
											<div class="tit tit1">
												<div class="name"><span item-i18n="html"  lang-msg='bl_facet_year'>出版年</span></div>
												<ul>
												  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2018')">2018(16)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2017')">2017(17)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2016')">2016(5)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2015')">2015(4)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2014')">2014(5)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2013')">2013(3)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2011')">2011(6)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2010')">2010(8)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2009')">2009(1)</a></li>
								                  
												   <li class="li-data"><a href="JavaScript:facetSearch('year','2008')">2008(1)</a></li>
								                  
												</ul>
											</div>
										</div>
									 </div>
									</span>
								 
							
						</dt> 
						<dd>
						    <ul class="text-list">
					            
								     <li><a href="JavaScript:facetSearch('year','2018')">2018(16)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2017')">2017(17)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2016')">2016(5)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2015')">2015(4)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2014')">2014(5)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2013')">2013(3)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2011')">2011(6)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2010')">2010(8)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2009')">2009(1)</a></li>
			                    
								     <li><a href="JavaScript:facetSearch('year','2008')">2008(1)</a></li>
			                    
							</ul>
						</dd>
		   </dl>
        </div>
        
        <div class="booklist-box-right">
             
            <div class="booklist-page">
	            
<div class="paging-box">
	<div class="paging-box-code">
		<div style="float:left;">

		</div>
		<input type="text" class="input-keyword box-code-jump" style="width:40px;margin-left:6px;float: left;text-align: center;">
		<a href="javascript:;" class="jumpBtnCls box-code-jump" item-i18n="text"  lang-msg='page_jump'>跳转</a>
	</div>

	<span class="num" item-i18n="html"  lang-msg='page_count_msg'>共计：0/0</span>
 </div>


			</div>
			
			<!-- 图书信息 -->
			
			<ul class="book-list">
			        
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=471544"  title="濒死之眼">	
                          <input type="hidden" value="978-7-5327-6007-7">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="濒死之眼" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=471544"  title="濒死之眼" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;濒死之眼
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(471544)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(471544,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日) 东野圭吾著；匡匡译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：上海;上海译文出版社:2013</span>
								               <span><label>ISBN</label>：978-7-5327-6007-7</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：东野圭吾作品</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="471544" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="471544" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=471544" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        暂无简介
					        
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=591479"  title="没有凶手的暗夜">	
                          <input type="hidden" value="978-7-02-013490-8">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="没有凶手的暗夜" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=591479"  title="没有凶手的暗夜" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;没有凶手的暗夜
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(591479)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(591479,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日)东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;人民文学出版社:2010</span>
								               <span><label>ISBN</label>：978-7-02-013490-8</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：东野圭吾作品</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="591479" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="591479" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=591479" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        
					        99读书人
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=591478"  title="白马山庄谜案">	
                          <input type="hidden" value="978-7-02-013488-5">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="白马山庄谜案" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=591478"  title="白马山庄谜案" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;白马山庄谜案
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(591478)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(591478,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日)东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;人民文学出版社:2011</span>
								               <span><label>ISBN</label>：978-7-02-013488-5</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：东野圭吾作品</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="591478" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="591478" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=591478" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        
					        99读书人
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=590562"  title="白马山庄谜案">	
                          <input type="hidden" value="978-7-02-013488-5">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="白马山庄谜案" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=590562"  title="白马山庄谜案" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;白马山庄谜案
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(590562)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(590562,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日)东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;人民文学出版社:2011</span>
								               <span><label>ISBN</label>：978-7-02-013488-5</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：东野圭吾作品</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="590562" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="590562" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=590562" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        
					        99读书人
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=590563"  title="没有凶手的暗夜">	
                          <input type="hidden" value="978-7-02-013490-8">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="没有凶手的暗夜" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=590563"  title="没有凶手的暗夜" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;没有凶手的暗夜
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(590563)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(590563,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日)东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;人民文学出版社:2010</span>
								               <span><label>ISBN</label>：978-7-02-013490-8</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：东野圭吾作品</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="590563" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="590563" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=590563" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        
					        99读书人
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=366758"  title="嫌疑人X的献身">	
                          <input type="hidden" value="978-7-5442-4169-4">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="嫌疑人X的献身" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=366758"  title="嫌疑人X的献身" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;嫌疑人X的献身
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(366758)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(366758,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日) 东野圭吾著；刘子倩译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：海口;南海出版公司:2008</span>
								               <span><label>ISBN</label>：978-7-5442-4169-4</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：新经典文库</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="366758" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="366758" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=366758" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        暂无简介
					        
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=363879"  title="以眨眼干杯">	
                          <input type="hidden" value="978-7-122-11178-4">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="以眨眼干杯" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=363879"  title="以眨眼干杯" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;以眨眼干杯
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(363879)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(363879,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日) 东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;化学工业出版社:2011</span>
								               <span><label>ISBN</label>：978-7-122-11178-4</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="363879" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="363879" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=363879" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        暂无简介
					        
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=214879"  title="回廊亭杀人事件">	
                          <input type="hidden" value="978-7-5075-3108-4">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="回廊亭杀人事件" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=214879"  title="回廊亭杀人事件" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;回廊亭杀人事件
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(214879)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(214879,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日)东野圭吾著；陈祖懿译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;华文出版社:2010</span>
								               <span><label>ISBN</label>：978-7-5075-3108-4</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="214879" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="214879" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=214879" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        
					        青马文库 东野圭吾作品集
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=417012"  title="圣女的救济">	
                          <input type="hidden" value="978-7-5090-0632-0">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="圣女的救济" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=417012"  title="圣女的救济" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;圣女的救济
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(417012)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(417012,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日) 东野圭吾；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;当代世界出版社:2010</span>
								               <span><label>ISBN</label>：978-7-5090-0632-0</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：青马文库</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="417012" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="417012" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=417012" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        暂无简介
					        
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			        
			        <li class="book-info-li">
			        	  <span class="check-bnt book-checkbox-list">
						  
						   
						  </span>
						<a href="bookdetail.jsp?id=434841"  title="没有凶手的杀人夜">	
                          <input type="hidden" value="978-7-02-008186-8">
						  <span class="bookimg">
		                     
							   
							    
							    <div class="no-image">
					                  
									   
				                         
				                             <img  src="images/book_img_3.jpg" title="没有凶手的杀人夜" style="width: 90px;height: 120px;">	
				                        
				                      
							     </div> 
							   
							
							
						  </span>							  
						</a>

						<div class="book-fld">
						    <div class="clearfix">
							    <h3 class="fld-title">
										<a href="bookdetail.jsp?id=434841"  title="没有凶手的杀人夜" >
										
								          
								         
								      
								           
				                         &nbsp;&nbsp;没有凶手的杀人夜
				                         
								        </a>
								       
								</h3>
								<div class="book-handler-bnt">
								       <a  href="javascript:void(0)" title="添加临时书单" onclick="addTempBookList(434841)">
								           <img alt="" src="images/booklist.png"><label item-i18n="html"  lang-msg='bl_addbooklist'>添加书单</label>
								       </a>
								       
	                                   <a  href="javascript:void(0)" title="放入我的书架" onclick="saveMyBookList(434841,0)">
	                                      <img alt="" src="images/bookshelf.png"><label item-i18n="html"  lang-msg='bl_addbookself'>放入书架</label>
	                                   </a>
								</div>
							</div>
							<div class="fld-info">
					
							               <div class="div-info-fld"><span><label item-i18n="html"  lang-msg='author'>作者</label>：(日) 东野圭吾著；袁斌译</span>
							
							              
							               </div>
							               <div class="div-info-fld">
								               <span><label item-i18n="html"  lang-msg='source'>出处</label>：北京;人民文学出版社:2010</span>
								               <span><label>ISBN</label>：978-7-02-008186-8</span>
								               <span><label item-i18n="html"  lang-msg='seriesname'>丛书名</label>：</span>
							               </div>
		
									
										
							</div>

							<div class="book-list-fld-bnt">
							
							     
								     <a href="javascript:void(0)" id="434841" class="show-hld-list" item-i18n="text"  lang-msg='bd_holdlist'>馆藏列表</a>
								
								<a href="javascript:void(0)" class="show-book-info-list"  id="434841" item-i18n="text"  lang-msg='bl_content'>内容简介</a>
							    <a href="bookdetail.jsp?id=434841" item-i18n="text"  lang-msg='bd_info'>图书详情</a>
							</div>
							
						</div>
					    
					    <div style="clear:both;">
					      <div class="book-info-box" style="padding:4px 10px;display: none;"> 
					       
					        暂无简介
					        
					       </div>
					       <div class="hld-list-box" style="padding:4px 10px;display: none;"> 
					        
					       </div>
					       
					     
					    </div>
					</li>
					
					
					
			</ul>
			
		    <div class="booklist-page">
	               
<div class="paging-box">
	<div class="paging-box-code">
		<div style="float:left;">

		</div>
		<input type="text" class="input-keyword box-code-jump" style="width:40px;margin-left:6px;float: left;text-align: center;">
		<a href="javascript:;" class="jumpBtnCls box-code-jump" item-i18n="text"  lang-msg='page_jump'>跳转</a>
	</div>

	<span class="num" item-i18n="html"  lang-msg='page_count_msg'>共计：0/0</span>
 </div>


			</div>
			
        </div>
       
 
        
  </div>
  <div style="height: 80px;clear: both;"></div>
   <!-- 页脚 -->
  

<div  class="footer" >
 
	Copyright ©2018 上海阿法迪智能数字科技股份有限公司  2021-08-06
  
   
</div>
 
</body>


<script type="text/javascript" src="/opac/third-party/js/jquery-1.8.3.min.js?version=2021-08-06"></script> 
<script type="text/javascript" src="/opac/js/common.js?version=2021-08-06"></script>
<script type="text/javascript" src="/opac/js/solrpagination.js?version=2021-08-06"></script>
<script type="text/javascript" src="/opac/js/mystorage.js?version=2021-08-06"></script>
<script type="text/javascript" src="/opac/third-party/jquery-i18n/jquery.i18n.properties.js?version=2021-08-06"></script> 
<script type="text/javascript" src="/opac/js/i18nUitl.js?version=2021-08-06"></script>
<script type="text/javascript">
var ctx ='/opac';

function advancedSearch(){
	var url = ctx + "/page/book/advancedsearch.jsp";
	$(window).attr('location', url);
}

</script>




<script type="text/javascript" src="/opac/js/search.js?version=2021-08-06"></script>
<script type="text/javascript" src="/opac/third-party/jquery.autocomplete-1.1.3/jquery.autocomplete.js"></script>
<script type="text/javascript" src="/opac/js/tagbox.js"></script>
<script type="text/javascript" src="/opac/third-party/echart/echarts.js"></script> 
<script type="text/javascript" src="/opac/third-party/echart/macarons.js"></script> 
<script type="text/javascript" src="/opac/third-party/echart/mychart.js?version=2021-08-06"></script> 


<script type="text/javascript">
var _locallist='null';
_locallist= ","+_locallist+",";
_locallist='';
$(function(){
	
	//中图分类
	$(".sidelist-dt .item").hover(function(){
		$(this).addClass("layer");
	},function(){
		$(this).removeClass("layer");
	});
	
	
	$(".filter-page").click(function(){
		var value  = $(this).attr("value");
		if(value == "0"){
			$(this).addClass("select-filter-tag");
			$(this).attr("value","1");
			this.innerHTML="隐藏趋势图";
			$(".chart-year").show();
		}else{
			$(this).removeClass("select-filter-tag");
			$(this).attr("value","0");
			this.innerHTML="显示趋势图";
			$(".chart-year").hide();
		}

	});
	
	window.onunload=function(){
/* 	   alert("123") */
	}
	
});
function initSolrBook(){
	  solrBook.searchtype = 'keyword';
	  solrBook.searchkey = '东野圭吾';
	  solrBook.foundnum = '66';
	  solrBook.page = '1';
	  solrBook.pagesize = '10';
	  solrBook.libcode = '';
	  solrBook.location = '';
	  
	  if(!solrBook.libcode){
		  $("#libcode").val("");
	  }
	  solrBook.sysid = '';
	  solrBook.author = '';
	  solrBook.publish = '';
	  solrBook.year = '';
	  solrBook.endyear = '';
	  solrBook.classnosub = '';
	  solrBook.subject = '';
	  solrBook.spelltext = '';
	  writeSearchLog(solrBook);
	  initSpellText(solrBook.spelltext); 
	  initAutoComplete();  
      handlerInitPage();
	  $("#sortkey").val('score');
	  $("#sorttype").val('desc');
      initPagingBoxData(solrBook);
	  initPageDefaultData(solrBook);
 	  initHotSearckKey(); 
}

function initSpellText(spelltext){
	if(spelltext){

		var  html= "<a style='color: #ff5e0f;' href=\"JavaScript:newSearch('"+spelltext+"')\">"+ spelltext +"</a>";
		$(".spell-box").html(jQuery.i18n.prop("bl_se_tip_result",html));
	}
	
	
}

function initAutoComplete(){
	
	var onAutocompleteSelect =function(value, data) {   
    }; 
    var options = {
        serviceUrl:  '/opac/par/common/QuerySuggest.do',//获取数据的后台页面  
        width: 140,//提示框的宽度
        delimiter: /(,|;)\s*/,//分隔符
        onSelect: onAutocompleteSelect,//选中之后的回调函数
        deferRequestBy: 0, //单位微秒
        params: {},//参数
        noCache: false,//是否启用缓存 默认是开启缓存的
    };
   $('#keyword').autocomplete(options);  
}

function initHotSearckKey(){
	    $(".hotSearchKey").hide();
	    var url = '/opac/par/common/getHotSearckKey.do';
		var param = {};
		$.post(url, param, function(data) {
			if(data.length > 0){
				var html = "";
				for(var i = 0 ;i < data.length;i++){	
					html += "<a href=\"JavaScript:newSearch('"+data[i].keyword+"')\">"+ data[i].keyword +"</a>";
				}
				$("#tagbox").html(html);
				$(".hotSearchKey").show();
				initTagBox();
			}
			
		}, 'json'); 
};
	
function newSearch(key){
	
	  $("#searchtype").val("keyword");
	  $("#searchkey").val(key);
	  var formbook = document.getElementById('formbook');
	  formbook.submit();
}	
	

function handlerInitPage(){
	
	 var record ={};
	 
		  record ={};
		  record.key = "0";
		  record.name = "图书";
		  sysidList.push(record);
     
    
    
    
	  record ={};
	  record.key = "001";
	  record.name = "中原科技学院图书馆";
	  libcodeList.push(record);
    
	  record ={};
	  record.key = "002";
	  record.name = "中原科技学院图书馆(许昌)";
	  libcodeList.push(record);
    
    
    
	  record ={};
	  record.key = "ZWSK";
	  record.name = "中文书库";
	  locationList.push(record);
    
	  record ={};
	  record.key = "YBSK";
	  record.name = "样本书库";
	  locationList.push(record);
    
	  record ={};
	  record.key = "0006";
	  record.name = "立身书库";
	  locationList.push(record);
    
	  record ={};
	  record.key = "0003";
	  record.name = "新书书库";
	  locationList.push(record);
    
    
    
   
    
	  record ={};
	  record.key = "I";
	  record.name = "I 文学";
	  classnosubList.push(record);
    
    
    
 	  record ={};
 	  record.key = "16";
 	  record.name = "2018";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "17";
 	  record.name = "2017";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "5";
 	  record.name = "2016";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "4";
 	  record.name = "2015";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "5";
 	  record.name = "2014";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "3";
 	  record.name = "2013";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "6";
 	  record.name = "2011";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "8";
 	  record.name = "2010";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "1";
 	  record.name = "2009";
 	  yearList.push(record);
     
 	  record ={};
 	  record.key = "1";
 	  record.name = "2008";
 	  yearList.push(record);
     
    var chartParam = {};
    chartParam.title = "书目数量-出版年趋势图";
    chartParam.legend = "出版年";
    chartParam.fun = "click"; 
    chartParam.key = "key"; 
    chartParam.name = "name";
    chartParam.xunit = "年";
 	buildMyChart(yearList,chartParam);
    
}



</script>

</html>
