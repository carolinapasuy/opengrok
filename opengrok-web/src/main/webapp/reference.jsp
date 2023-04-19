<%--

Copyright (c) 2021, 2022, Oracle and/or its affiliates. All rights reserved.
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="false" errorPage="error.jsp" import="org.opengrok.web.PageConfig" %>
<%@ page import="org.opengrok.indexer.configuration.RuntimeEnvironment" %>
<%
    {
        PageConfig cfg = PageConfig.get(request);
        cfg.setTitle("OpenGrok Settings");
    }
%>
<%@ include file="/httpheader.jspf" %>
<head>
    <script>
        var showDiv1 = true;
        var showDiv2 = false;
        var showDiv3 = false;
        var showDiv4 = false;
        var showDiv5 = false;

        function toggleDivs() {
            if (showDiv1) {
                document.getElementById("div1").style.display = "block";
            } else {
                document.getElementById("div1").style.display = "none";
            }
            if (showDiv2) {
                document.getElementById("div2").style.display = "block";
            } else {
                document.getElementById("div2").style.display = "none";
            }
            if (showDiv3) {
                document.getElementById("div3").style.display = "block";
            } else {
                document.getElementById("div3").style.display = "none";
            }
            if (showDiv4) {
                document.getElementById("div4").style.display = "block";
            } else {
                document.getElementById("div4").style.display = "none";
            }
            if (showDiv5) {
                document.getElementById("div5").style.display = "block";
            } else {
                document.getElementById("div5").style.display = "none";
            }
        }

        function toggleDiv1() {
            showDiv1 = true;
            showDiv2 = false;
            showDiv3 = false;
            showDiv4 = false;
            showDiv5 = false;
            toggleDivs();
        }

        function toggleDiv2() {
            showDiv1 = false;
            showDiv2 = true;
            showDiv3 = false;
            showDiv4 = false;
            showDiv5 = false;
            toggleDivs();
        }

        function toggleDiv3() {
            showDiv1 = false;
            showDiv2 = false;
            showDiv3 = true;
            showDiv4 = false;
            showDiv5 = false;
            toggleDivs();
        }

        function toggleDiv4() {
            showDiv1 = false;
            showDiv2 = false;
            showDiv3 = false;
            showDiv4 = true;
            showDiv5 = false;
            toggleDivs();
        }

        function toggleDiv5() {
            showDiv1 = false;
            showDiv2 = false;
            showDiv3 = false;
            showDiv4 = false;
            showDiv5 = true;
            toggleDivs();
        }
    </script>
</head>

<body  onload="toggleDiv1()">
    <div id="page">
        <header id="whole_header">
            <%@include file="/pageheader.jspf" %>
                <div id="Masthead">
                    <a href="<%= request.getContextPath() %>/"><span id="home"></span>Home</a>
                </div>
        </header>
        <div id="sbar"></div>
        <div style="padding-left: 1rem;">
            <h1>Results:</h1>
            <a href="#" onclick="toggleDiv1()">AccountService</a>->
            <a href="#" onclick="toggleDiv2()">AccountController</a>->
            <a href="#" onclick="toggleDiv3()">AccountService</a>->
            <a href="#" onclick="toggleDiv4()">AccountRepository</a>->
            <a href="#" onclick="toggleDiv5()">INSERT_PIONEER_PRICE</a>
            <br>
            <br>
            <br>
            <div id="div1" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word;">
                <pre>
21  createPricePioner(PricePioneerDTO:pricePioneer):Observable<void>{ 
22    return this.httpClient.post<void>(this.baseUrl+"create",pricePioneer)
23
24  }
              </pre>
            </div>
            <div id="div2" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word;">
                <pre>
8	@Override
9	@RequestMapping(value = "/pricePioneer/create", method = RequestMethod.POST)
10	public ResponseEntity<String> create(@RequestBody PricePioneer pricePioneer)
11  {		
12		pricePioneerService.save(pricePioneer);
13		return new ResponseEntity("Ok",HttpStatus.CREATED);		
14	}
              </pre>
            </div>

            <div id="div3" style="width: 1200px; border: 1px solid black; font-size: 15px;">
                <pre>
17	@Override
18	public void save(PricePioneer pricePioneer) {		
19		pricePioneerRepository.save(pricePioneer);
20	}
              </pre>
            </div>
            <div id="div4" style="width: 1200px; border: 1px solid black; font-size: 15px;">
                <pre>
13		@Override
14	public void save(PricePioneer pricePioneer) {
15		jdbcTemplate.update("CALL insert_pioneer_price(?, ?, ?,?,?,?)", 
16		pricePioneer.getName_implement(), pricePioneer.getDescription_implement(), 
18		pricePioneer.getTypeImplement().getTypeimplementid(),pricePioneer.getPrice(),
19		pricePioneer.getRegion().getRegionid(),pricePioneer.getEffective_date());
20
21	}
              </pre>
            </div>
            <div id="div5" style="width: 1200px; border: 1px solid black; font-size: 15px;overflow-wrap: break-word;">
                <pre>
2  CREATE OR REPLACE EDITIONABLE PROCEDURE "APP_LIQ_PRECIOS"."INSERT_PIONEER_PRICE" 
3(
4    name_implement           VARCHAR2,
5    description_implement    VARCHAR2,
6    typeImplementId          NUMBER,
7    price                    NUMBER,
8    region_id                NUMBER,
9    effective_date           DATE
10 )
11 IS 	 
12    pricepioneerid NUMBER;
13 BEGIN
14    -- get the new price pioneer id
15    SELECT APP_LIQ_PRECIOS.PRICEPIONEER_ID_SEQ.nextval INTO pricepioneerid FROM DUAL;
16
17   -- create price pioneer
18   INSERT INTO APP_LIQ_PRECIOS.PRICEPIONEER (pricepioneerid, name_implement,description_implement,typeImplementId,price,regionId,effective_date)
19        VALUES (pricepioneerid, name_implement,description_implement,typeImplementId,price,region_id,effective_date);
20
21
22 END;
              </pre>
            </div>
        </div>
    </div>
</body>

</html>

<%@include file="/foot.jspf" %>