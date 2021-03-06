
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        body html{
            margin: 0;
            padding: 0;
         }
        thead{
            font-weight: bold;
        }
        tr td{
            height: 2.0em;
            text-align: center;
        }
        ul {
            margin: 0;
            padding: 0;
        }

        .filterBox{
            float: left;
            margin-left: 10%;
            margin-bottom: 8px;
            padding: 0;
        }
        li{
            display: inline;
            margin-right: 8px;
            list-style: none;
        }
        .bottom{
            float: right;
            margin-right: 10%;
            margin-top: 8px;
        }
    </style>
    <script>
        window.onload = function(){
            selectByCondition();
            document.getElementById("selectBtn").onclick = function(){
                selectByCondition();
            }
            document.getElementById("cleanSelectBtn").onclick = function(){
                document.getElementById("rnoText").value = "";
                document.getElementById("rnameText").value = "";
                document.getElementById("descriptionText").value = "";
                selectByCondition();
            }
            document.getElementById("showRowSelect").onchange = function(){
                selectByCondition();
            }
            document.getElementById("showPageSelect").onchange = function () {
                selectByCondition();
            }
            document.getElementById("prevPageBtn").onclick = function() {
                var pageSelect = document.getElementById("showPageSelect");
                var pageSelectText = parseInt(pageSelect.value);
                if(1 == pageSelectText){
                    return;
                }
                pageSelectText--;
                pageSelect.value = pageSelectText;
                selectByCondition();
            }
            document.getElementById("nextPageBtn").onclick = function() {
                var pageSelect = document.getElementById("showPageSelect");
                var pageSelectText = parseInt(pageSelect.value);
                var maxPage = pageSelect.childElementCount;
                if(pageSelectText == maxPage){
                    return;
                }
                pageSelectText++;
                pageSelect.value = pageSelectText;
                selectByCondition();
            }
        }
        function selectByCondition() {
            var rno = document.getElementById("rnoText").value;
            var rname = document.getElementById("rnameText").value;
            var description = document.getElementById("descriptionText").value;
            var row = document.getElementById("showRowSelect").value;
            var page = document.getElementById("showPageSelect").value;

            var xhr = new XMLHttpRequest();
            xhr.open("post","roleList.do",true);
            xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            xhr.send("rno="+rno+"&rname="+rname+"&description="+description+"&row="+row+"&page="+page);
            xhr.onreadystatechange = function () {
                if(xhr.readyState== 4 && xhr.status == 200){
                    show(xhr.responseText);
                }
            }
        }

        function show(result){
            var obj = eval('('+result+')');
            var roles = obj.list;
            var maxPage = obj.maxPage;
            //?????????????????????????????????????????????
            var pageSelect = document.getElementById("showPageSelect");
            var nowPage = pageSelect.value;
            pageSelect.innerHTML = '';

            for(var i=1;i<=maxPage;i++){
                pageSelect.innerHTML += '<option>'+i+'</option>';
            }
            if(nowPage < maxPage){
                pageSelect.value = nowPage ;
            }else{
                pageSelect.value = maxPage ;
            }
            //????????????????????????????????????
            var body = document.getElementById("tableBody");
            //????????????
            body.innerHTML = '';
            if(roles.length == 0){
                //????????????
                body.innerHTML = '<tr><td align="center" colspan="4">??????????????????</td></tr>' ;
            }
            for(var i=0;i<roles.length;i++){
                var tr = document.createElement("tr");
                body.appendChild(tr);
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                td1.innerText = roles[i].rno;
                td2.innerText = roles[i].rname;
                td3.innerText = roles[i].description;
                td4.innerHTML = '<a href="">??????</a> | <a href="">??????</a>';
            }

        }
    </script>
</head>
<body>
<div class="title"><h2 align="center">????????????</h2></div>
<div class="filterBox">
    <ul>
        <li><input id="rnoText" type="text" placeholder="?????????????????????"></li>
        <li><input id="rnameText" type="text" placeholder="?????????????????????"></li>
        <li><input id="descriptionText" type="text" placeholder="?????????????????????"></li>
        <li><input id="selectBtn" type="button" value="??????"></li>
        <li><input id="cleanSelectBtn" type="button" value="????????????"></li>
    </ul>
</div>
<div class="role-table">
    <table align="center" border="1" width="80%" cellspacing="0">
        <thead>
        <tr>
            <td >????????????</td>
            <td>????????????</td>
            <td>????????????</td>
            <td>??????</td>
        </tr>
        </thead>
        <tbody id="tableBody">

        </tbody>
    </table>
</div>

<div class="bottom">
    <ul>
        <li>
            ??????
            <select id="showRowSelect">
                <option>5</option>
                <option>10</option>
                <option>15</option>
            </select>
            ???
        </li>
        <li>
            ??????
            <select name="" id="showPageSelect">
                <option >1</option>
            </select>
            ???
        </li>
        <li>
            <button id="prevPageBtn">?????????</button>
        </li>
        <li>
            <button id="nextPageBtn">?????????</button>
        </li>
    </ul>
</div>
</body>
</html>
