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
            <a href="#" onclick="toggleDiv5()">INSERT_PIONEER_PRICE</a>->
            <br>
            <br>
            <br>
            <div id="div1" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word;">
                <pre>
  createPricePioner(PricePioneerDTO:pricePioneer):Observable<void>{ 
    return this.httpClient.post<void>(this.baseUrl+"create",pricePioneer)

  }
              </pre>
            </div>
            <div id="div2" style="width: 1200px; border: 1px solid black;  font-size: 15px;overflow-wrap: break-word;">
                <pre>
	@Override
	@RequestMapping(value = "/pricePioneer/create", method = RequestMethod.POST)
	public ResponseEntity<String> create(@RequestBody PricePioneer pricePioneer) {		
		pricePioneerService.save(pricePioneer);
		return new ResponseEntity("Ok",HttpStatus.CREATED);		
	}
              </pre>
            </div>

            <div id="div3" style="width: 1200px; border: 1px solid black; font-size: 15px;">
                <pre>
	@Override
	public void save(PricePioneer pricePioneer) {		
		pricePioneerRepository.save(pricePioneer);
	}
              </pre>
            </div>
            <div id="div4" style="width: 1200px; border: 1px solid black; font-size: 15px;">
                <pre>
		@Override
	public void save(PricePioneer pricePioneer) {
		jdbcTemplate.update("CALL insert_pioneer_price(?, ?, ?,?,?,?)", 
		pricePioneer.getName_implement(), pricePioneer.getDescription_implement(), 
		pricePioneer.getTypeImplement().getTypeimplementid(),pricePioneer.getPrice(),
		pricePioneer.getRegion().getRegionid(),pricePioneer.getEffective_date());

	}
              </pre>
            </div>
            <div id="div5" style="width: 1200px; border: 1px solid black; font-size: 15px;overflow-wrap: break-word;">
                <pre>
  CREATE OR REPLACE EDITIONABLE PROCEDURE "APP_LIQ_PRECIOS"."INSERT_PIONEER_PRICE" 
(
    name_implement           VARCHAR2,
    description_implement    VARCHAR2,
    typeImplementId          NUMBER,
    price                    NUMBER,
    region_id                NUMBER,
    effective_date           DATE
)
IS 	 
    pricepioneerid NUMBER;
BEGIN
    -- get the new price pioneer id
    SELECT APP_LIQ_PRECIOS.PRICEPIONEER_ID_SEQ.nextval INTO pricepioneerid FROM DUAL;

    -- create price pioneer
    INSERT INTO APP_LIQ_PRECIOS.PRICEPIONEER (pricepioneerid, name_implement,description_implement,typeImplementId,price,regionId,effective_date)
        VALUES (pricepioneerid, name_implement,description_implement,typeImplementId,price,region_id,effective_date);


END;
              </pre>
            </div>
        </div>
    </div>
</body>

</html>

<%@include file="/foot.jspf" %>