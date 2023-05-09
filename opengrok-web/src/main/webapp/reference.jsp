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
        function showDiv(id) {
            var div = document.getElementById(id);
            div.style.display = "block";
        }

        function hideDiv(id) {
            var div = document.getElementById(id);
            div.style.display = "none";
        }

        function toggleDiv(id) {
            var div = document.getElementById(id);
            if (div.style.display === "none") {
                showDiv(id);
            }
            var divIds = ["div1", "div2", "div3", "div4", "div5"];
            for (var i = 0; i < divIds.length; i++) {
                if (divIds[i] !== id) {
                    hideDiv(divIds[i]);
                }
            }
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
            <a href="#" onclick="toggleDiv('div1')">AccountService.js (22)</a>->
            <a href="#" onclick="toggleDiv('div2')">AccountController (12)</a>->
            <a href="#" onclick="toggleDiv('div3')">AccountService (19)</a>->
            <a href="#" onclick="toggleDiv('div4')">AccountRepository (15)</a>->
            <a href="#" onclick="toggleDiv('div5')">INSERT_PIONEER_PRICE (2)</a>
            <br>
            <br>
            <br>
            <div id="div1" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word; display: block">
                <pre>
    baseUrl =http://localhost:8081/
21  createPricePioner(PricePioneerDTO:pricePioneer):Observable<void>{ 
<strong>22    return this.httpClient.post<void>(this.baseUrl+"create",pricePioneer)</strong>
23
24  }
              </pre>
            </div>
            <div id="div2" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word; display: none">
                <pre>
8	@Override
9	@RequestMapping(value = "/pricePioneer/create", method = RequestMethod.POST)
10	public ResponseEntity<String> create(@RequestBody PricePioneer pricePioneer)
11  {		
<strong>12		pricePioneerService.saveAccount(pricePioneer);</strong>
13		return new ResponseEntity("Ok",HttpStatus.CREATED);		
14	}
              </pre>
            </div>

            <div id="div3" style="width: 1200px; border: 1px solid black; font-size: 15px; display: none">
                <pre>
17	@Override
18	public void saveAccount(PricePioneer pricePioneer) {		
19	<strong>	pricePioneerRepository.saveAccount(pricePioneer);</strong>
20	}
              </pre>
            </div>
            <div id="div4" style="width: 1200px; border: 1px solid black; font-size: 15px; display: none">
                <pre>
13		@Override
14	public void saveAccount(PricePioneer pricePioneer) {
<strong>15		jdbcTemplate.update("CALL insert_pioneer_price(?, ?, ?,?,?,?)", </strong>
16		pricePioneer.getName_implement(), pricePioneer.getDescription_implement(), 
18		pricePioneer.getTypeImplement().getTypeimplementid(),pricePioneer.getPrice(),
19		pricePioneer.getRegion().getRegionid(),pricePioneer.getEffective_date());
20
21	}
              </pre>
            </div>
            <div id="div5" style="width: 1200px; border: 1px solid black; font-size: 15px;overflow-wrap: break-word; display: none">
                <pre>
<strong>2  CREATE OR REPLACE EDITIONABLE PROCEDURE "APP_LIQ_PRECIOS"."INSERT_PIONEER_PRICE" </strong>
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