jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "currency-pre": function ( a ) {
        //a = (a==="-") ? 0 : a.replace( /[^\d\-\.]/g, "" );
        a=a.replace( /[(]/gi, "-" ).replace( /[)]/gi, "" );
        a = (a==="-") ? 0 : a.replace( /[^a-z0-9.-\s]/gi, "" );
        return parseFloat( a );
    },

    "currency-asc": function ( a, b ) {
        return a - b;
    },

    "currency-desc": function ( a, b ) {
        return b - a;
    }
} );


$(document).ready(function(){

  $("select").select2();

    // Range Slider *********************
    var rsvmin = parseInt( $("[name='range-slider-value-min']").val() );
    var rsvmax = parseInt( $("[name='range-slider-value-max']").val() );

    $(".range-slider").slider(
      { id: "slider12c", min: 0, max: 400, range: true, value: [ rsvmin, rsvmax ] });
    

    /* Menu Code to overwrite the existing JS code */
    /* Menu items with out childern */
    $('.navbar-nav >li').each(function () {
        if($(this).children('a').attr('href') == $(location).attr('pathname').replace("/index.cfm","")){
          //console.log($(this).children('a').attr('href'));
          $($(this).closest('li')[0]).addClass("active");
        }
    });

    /* 34752E01-94B1-C363-BD152098AC434FCA then /fiscal-condition/appropriation-inquiries/ */
    /* If we have more Link serverId then we will add the logic below but for now we are good */
    /*$(location).attr('href').replace($(location).attr('host'),"").replace($(location).attr('protocol'),"").replace("//","").replace("/?LinkServID=","") */

    if($(location).attr('pathname') == "/"){
     //console.log($(location).attr('href').replace($(location).attr('host'),"").replace($(location).attr('protocol'),"").replace("//","").replace("/?LinkServID=",""));
     var PageName = '/fiscal-condition/appropriation-inquiries/'
    }
    else{
     var PageName = $(location).attr('pathname').replace("/index.cfm","");
    }
    /* Menu items first level childern*/
    $('.navbar-nav > li').find('a.child').each(function () {
        if($(this).attr('href') == PageName){
           $($(this).parent().closest('ul').closest('li')[0]).addClass("active");
           //console.log($(this).attr('href'));
        }
    });

    /* This is to allow the first level click on menu items */
    $(".navbar-nav li").find("a").click(function(e){
       if($(this).parent().find(".dropdown-menu").length == "0" || $(this).attr("href") == "/find-a-revenue/" || $(this).attr("href") =="/find-an-expense/"
        || $(this).attr("href") =="/find-reports/"){
          window.location.href=$(this).attr("href");
       }
    });


   $("#popular .block").mouseover(function(event) {
    $(this).css("background-color","#000923");
   });
   $("#popular .block").mouseout(function(event) {
    if($(this).find("a").attr("href").indexOf("revenue") >= 1){
      $(this).css("background-color","#143b58");
     }else{
      $(this).css("background-color","#376c8d");
     }
   });

	$('.dt-buttons').on( "click", function() {
  		console.log( 'click' );
	});
	// datatable init

if($(".datatable").length) {

   $('.datatable').DataTable({
    columnDefs: [
       { type: 'currency', targets: "sum" }
       ,{ type: 'datetime-us-flex', targets: "cldate" }//[7,8]
    ],
     "initComplete": function(settings, json) {
       // this fixes the fixed first column width issue as well as the alignment issues
       $(window).trigger('resize');
     },
   "ordering": true,
   "info": true,
   "searching": false,
   "lengthChange": false,
   "scrollX": true,
   "scrollY": "50vh",
   "scrollCollapse": false,
   "pageLength": 50,
   "paging": true,
   "iDisplayLength": 50,
   "order": [],
   //   "ordering": true,
    // "info":     false,
    // "searching": false,
    // "lengthChange": false,
    // "scrollY":        "50vh",
    // "scrollX": true,
    // "scrollCollapse": false,
    // "paging":         false,
        "footerCallback": function ( row, data, start, end, display ) {
          //this.api().columns('.sum',{ page: 'current'}).every(function () { //Current page totals
          this.api().columns('.sum').every(function () { //Whole page totals
               var column = this;

              var sum = column
                 .data()
                 .reduce(function (a, b) {
                    if(isNaN(parseInt(a))){
                      if(a.indexOf('(') != -1){
                         var temp1 = -parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                      }else{
                           var temp1 = parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                      }
                    }else{
                       var temp1 = a;
                    }
                    if(isNaN(parseInt(b))){
                       if(b.indexOf('(') != -1){
                         var temp2 = -parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                       }
                       else{
                         var temp2 = parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                       }
                    }else{
                       var temp2 = b;
                    }

                    return parseFloat(temp1, 10) + parseFloat(temp2, 10);
                 });

              //$(column.footer()).html('$' + sum.toLocaleString());
               if(sum.toString().indexOf(',') != -1){
                     $(column.footer()).html("$"+addCommas(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
                   }
                   else{
                      if(isNaN(parseFloat(sum))){
                           $(column.footer()).html(sum);
                          }
                          else{
                                $(column.footer()).html("$"+addCommas(parseFloat(sum).toFixed(2)));
                          }
               }
               //$(column.footer()).html(DollarFormat(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
          });
      }
      /*,
         dom: 'Bfrtip',
         buttons: [
          {
              extend: 'csv',
              text: 'CSV',
              extension: '.csv',
              exportOptions: {
                  // modifier: {
                  //     page: 'current'
                  // }
              },
              title: 'table'
          }
         ]*/
    });
}

if($(".datatable thead").length){

  $('.datatable thead').on('click', 'th', function () {
    //position: relative; overflow: auto; width: 100%; height: 50vh;
    //$(".dataTables_scrollBody").attr("style","position: relative; overflow: auto; width: 100%; height: 50vh;");
    //$(".dataTables_scrollHead").attr("overflow: hidden; position: relative; border: 0px; width: 100%;");
    //$(".dataTables_scrollBody").attr("position: relative; overflow: auto; width: 100%; height: 50vh;");
    //var oTable = $('.datatable').dataTable();
    //oTable.fnSort([  [0,'asc']] );
      $('.datatable').DataTable().columns.adjust();
  });
}

if($(".datatable-export").length){
    $('.datatable-export').DataTable({
      columnDefs: [
         { type: 'currency', targets: "sum" }
       ],
      "initComplete": function(settings, json) {
          // this fixes the fixed first column width issue as well as the alignment issues
          $(window).trigger('resize');
      },
      "ordering": true,
      "info":     true,
      "searching": false,
      "lengthChange": false,
      "scrollX": true,
      //"scrollY": "50vh",
      "scrollCollapse": true,
      //"pageLength": 100,
        "pageLength": 20,
      "paging": true,
      "iDisplayLength": 50,
      "order": [],
        "footerCallback": function ( row, data, start, end, display ) {
          //this.api().columns('.sum',{ page: 'current'}).every(function () { //Current page totals
          this.api().columns('.sum').every(function () { //Whole page totals
                 var column = this;

                var sum = column
                   .data()
                   .reduce(function (a, b) {
                      if(isNaN(parseInt(a))){
                      if(a.indexOf('(') != -1){
                         var temp1 = -parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                      }else{
                           var temp1 = parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                      }
                      }else{
                         var temp1 = a;
                      }
                      if(isNaN(parseInt(b))){
                     if(b.indexOf('(') != -1){
                         var temp2 = -parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                     }
                     else{
                       var temp2 = parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                     }
                      }else{
                         var temp2 = b;
                      }

                      //return parseFloat(parseFloat(temp1, 10) + parseFloat(temp2, 10)).toFixed(2);
                    return parseFloat(temp1, 10) + parseFloat(temp2, 10);
                   });

                //$(column.footer()).html('$' + sum.toLocaleString());
              if(sum.toString().indexOf(',') != -1){
                    $(column.footer()).html("$"+addCommas(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
                  }
                  else{
                     if(isNaN(parseFloat(sum))){
                           $(column.footer()).html(sum);
                          }
                          else{
                                $(column.footer()).html("$"+addCommas(parseFloat(sum).toFixed(2)));
                          }
              }
              //$(column.footer()).html(DollarFormat(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
            });
        },
          dom: 'Bfrtip',
          buttons: [
            {
                extend: 'csv',
                text: 'CSV',
                extension: '.csv',
                exportOptions: {
                    // modifier: {
                    //     page: 'current'
                    // }
                },
                title: 'table'
            }
          ]
      });

// $('.datatable-export').on('click', 'th', function () {
//     $('.datatable-export').DataTable().columns.adjust();
// });
}

var table =   $('.datatable-export-fixed').DataTable( {
        "initComplete": function(settings, json) {
          // this fixes the fixed first column width issue as well as the alignment issues
          $(window).trigger('resize');
        },
        columnDefs: [
           { type: 'currency', targets: "sum" }
         ],
          "ordering": true,
          "info":     true,
          "searching": false,
          "lengthChange": false,
          "scrollX": true,
          //"scrollY": "50vh",
          "scrollCollapse": true,
          //"pageLength": 100,
            "pageLength": 20,
          "paging": true,
          "fixedColumns":   {
              leftColumns: 2
          },
          "iDisplayLength": 50,
          "order": [],
            "footerCallback": function ( row, data, start, end, display ) {
                //this.api().columns('.sum',{ page: 'current'}).every(function () { //Current page totals
                  this.api().columns('.sum').every(function () { //Whole page totals
                  var column = this;
                  var sum = column
                     .data()
                     .reduce(function (a, b) {
                        if(isNaN(parseInt(a))){
                        if(a.indexOf('(') != -1){
                           var temp1 = -parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                        }else{
                             var temp1 = parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                        }
                        }else{
                           var temp1 = a;
                        }
                        if(isNaN(parseInt(b))){
                         if(b.indexOf('(') != -1){
                           var temp2 = -parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                         }
                         else{
                           var temp2 = parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                         }
                        }else{
                           var temp2 = b;
                        }
                        return parseFloat(temp1, 10) + parseFloat(temp2, 10);
                     });
                     if(sum.toString().indexOf(',') != -1){
                           $(column.footer()).html("$"+addCommas(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
                         }
                         else{
                          if(isNaN(parseFloat(sum))){
                           $(column.footer()).html(sum);
                          }
                          else{
                                $(column.footer()).html("$"+addCommas(parseFloat(sum).toFixed(2)));
                          }
                     }
                    //$(column.footer()).html(DollarFormat(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
              });
            },
              dom: 'Bfrtip',
              buttons: [
                {
                    extend: 'csv',
                    text: 'CSV',
                    extension: '.csv',
                    exportOptions: {
                        // modifier: {
                        //     page: 'current'
                        // }
                    },
                    title: 'table'
                }
              ]
      });

table.on('page.dt', function() {
  $('html, body').animate({
    scrollTop: $(".dataTables_wrapper").offset().top
   }, 'slow');
});


// $('.datatable-export-fixed').dataTable( {
//         "initComplete": function(settings, json) {
//             // this fixes the fixed first column width issue as well as the alignment issues
//             $(window).trigger('resize');
//           },
//         columnDefs: [
//            { type: 'currency', targets: "sum" }
//          ],  
//         "ordering": true,
//         "info":     true,
//         "searching": false,                
//         "sScrollY": "500px",
//         "scrollX":true,
//         "bScrollCollapse": true,
//         "bJQueryUI": true,
//         "aoColumnDefs": [
//             { "sWidth": "10%", "aTargets": [ -1 ] }
//         ],
//         "pageLength": 100,
//         "iDisplayLength": 50,        
//         "paging": true,        
//         "footerCallback": function ( row, data, start, end, display ) {
//               //this.api().columns('.sum',{ page: 'current'}).every(function () { //Current page totals
//               this.api().columns('.sum').every(function () { //Whole page totals
//                 var column = this;
//                 var sum = column
//                    .data()
//                    .reduce(function (a, b) {
//                       if(isNaN(parseInt(a))){
//                       if(a.indexOf('(') != -1){
//                          var temp1 = -parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
//                       }else{
//                            var temp1 = parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
//                       }
//                       }else{
//                          var temp1 = a;
//                       }
//                       if(isNaN(parseInt(b))){
//                        if(b.indexOf('(') != -1){
//                          var temp2 = -parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
//                        }
//                        else{
//                          var temp2 = parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
//                        }
//                       }else{
//                          var temp2 = b;
//                       }
//                       return parseFloat(temp1, 10) + parseFloat(temp2, 10);
//                    });
//                    if(sum.toString().indexOf(',') != -1){
//                          $(column.footer()).html("$"+addCommas(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
//                        }
//                        else{
//                         if(isNaN(parseFloat(sum))){
//                          $(column.footer()).html(sum);
//                         }
//                         else{
//                               $(column.footer()).html("$"+addCommas(parseFloat(sum).toFixed(2)));
//                         }
//                    }
//               });
//         },
//         dom: 'Bfrtip',
//               buttons: [
//                 {
//                     extend: 'csv',
//                     text: 'CSV',
//                     extension: '.csv',
//                     exportOptions: {
//                         // modifier: {
//                         //     page: 'current'
//                         // }
//                     },
//                     title: 'table'
//                 }
//         ]
//     } );
/*if($(".datatable-export-fixed").length){


	 	$('.datatable-export-fixed').DataTable( {
        "initComplete": function(settings, json) {
          // this fixes the fixed first column width issue as well as the alignment issues
          $(window).trigger('resize');
        },
        columnDefs: [
           { type: 'currency', targets: "sum" }
         ],
    		 	"ordering": true,
    			"info":     true,
    			"searching": false,
    			"lengthChange": false,
    			"scrollX":true,
    			"scrollY":        "50vh",
    			"scrollCollapse": false,
    			"pageLength": 100,
    			"paging": true,
    			"fixedColumns":   {
    	            leftColumns: 2
    	        },
    	        "fixedHeader": {
                	header: false,
                	footer: true
            	},
        		"iDisplayLength": 50,
                "order": [],
        		"footerCallback": function ( row, data, start, end, display ) {
    	        	//this.api().columns('.sum',{ page: 'current'}).every(function () { //Current page totals
              		this.api().columns('.sum').every(function () { //Whole page totals
    	            var column = this;
    	            var sum = column
    	               .data()
    	               .reduce(function (a, b) {
    	                  if(isNaN(parseInt(a))){
                        if(a.indexOf('(') != -1){
                           var temp1 = -parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                        }else{
                             var temp1 = parseFloat(a.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//a.replace(/$/g,"").replace(/,/g,"");
                        }
    	                  }else{
    	                     var temp1 = a;
    	                  }
    	                  if(isNaN(parseInt(b))){
                         if(b.indexOf('(') != -1){
                           var temp2 = -parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                         }
                         else{
                           var temp2 = parseFloat(b.replace(/\$|\,|\(|\)/g,'')).toFixed(2);//b.replace(/$/g,"").replace(/,/g,"");
                         }
    	                  }else{
    	                     var temp2 = b;
    	                  }
    	                  return parseFloat(temp1, 10) + parseFloat(temp2, 10);
    	               });
                     if(sum.toString().indexOf(',') != -1){
                           $(column.footer()).html("$"+addCommas(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
                         }
                         else{
                          if(isNaN(parseFloat(sum))){
                           $(column.footer()).html(sum);
                          }
                          else{
                                $(column.footer()).html("$"+addCommas(parseFloat(sum).toFixed(2)));
                          }
                     }
                    //$(column.footer()).html(DollarFormat(parseFloat(sum.replace(/\$|\,|\(|\)/g,'')).toFixed(2)));
    	        });
        		},
    	        dom: 'Bfrtip',
    	        buttons: [
    	        	{
    		            extend: 'csv',
    		            text: 'CSV',
    		            extension: '.csv',
    		            exportOptions: {
    		                // modifier: {
    		                //     page: 'current'
    		                // }
    		            },
    		            title: 'table'
    	        	}
    	        ]
    	});

}*/
  // fix for the fixed two column scrolling issue
  //$('.dataTables_scrollBody #DataTables_Table_0').css("margin-left", "0px");

// $('.datatable-export-fixed').on('click', 'th', function () {
//     $('.datatable-export-fixed').DataTable().columns.adjust();
// });

	// smooth scroll ********************
	$('a.scroll').click(function() {
	  if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
	    var target = $(this.hash);
	    target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
	    if (target.length) {
	      $('html,body').animate({
	        scrollTop: target.offset().top
	      }, 1000);
	      return false;
	    }
	  }
	});

    // bootstrap tooltip *********************
     $('[data-toggle="tooltip"]').tooltip();

    // checkbox ************************
    //$("input[type=radio], input[type=checkbox]").picker();

	// select option ********************
	//$("select").select2();

    // accordion **********************
    $('.c_accordion li.active .content').slideDown();
    $('.c_accordion li .opner').click(function(e){
        e.preventDefault();
        $(this).parent('li').toggleClass('active');
        $('.c_accordion li .content').not('.c_accordion li.active .content').slideUp();
        $('.c_accordion li.active .content').slideDown();
    });

    $('.DTFC_Cloned thead tr th').css('border-bottom', '0px');

});

Number.prototype.formatMoney = function(c, d, t){
var n = this,
    c = isNaN(c = Math.abs(c)) ? 2 : c,
    d = d == undefined ? "." : d,
    t = t == undefined ? "," : t,
    s = n < 0 ? "-" : "",
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };

// Page Loading *************************
/*! pace 1.0.0 */
(function(){var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X=[].slice,Y={}.hasOwnProperty,Z=function(a,b){function c(){this.constructor=a}for(var d in b)Y.call(b,d)&&(a[d]=b[d]);return c.prototype=b.prototype,a.prototype=new c,a.__super__=b.prototype,a},$=[].indexOf||function(a){for(var b=0,c=this.length;c>b;b++)if(b in this&&this[b]===a)return b;return-1};for(u={catchupTime:100,initialRate:.03,minTime:250,ghostTime:100,maxProgressPerFrame:20,easeFactor:1.25,startOnPageLoad:!0,restartOnPushState:!0,restartOnRequestAfter:500,target:"body",elements:{checkInterval:100,selectors:["body"]},eventLag:{minSamples:10,sampleCount:3,lagThreshold:3},ajax:{trackMethods:["GET"],trackWebSockets:!0,ignoreURLs:[]}},C=function(){var a;return null!=(a="undefined"!=typeof performance&&null!==performance&&"function"==typeof performance.now?performance.now():void 0)?a:+new Date},E=window.requestAnimationFrame||window.mozRequestAnimationFrame||window.webkitRequestAnimationFrame||window.msRequestAnimationFrame,t=window.cancelAnimationFrame||window.mozCancelAnimationFrame,null==E&&(E=function(a){return setTimeout(a,50)},t=function(a){return clearTimeout(a)}),G=function(a){var b,c;return b=C(),(c=function(){var d;return d=C()-b,d>=33?(b=C(),a(d,function(){return E(c)})):setTimeout(c,33-d)})()},F=function(){var a,b,c;return c=arguments[0],b=arguments[1],a=3<=arguments.length?X.call(arguments,2):[],"function"==typeof c[b]?c[b].apply(c,a):c[b]},v=function(){var a,b,c,d,e,f,g;for(b=arguments[0],d=2<=arguments.length?X.call(arguments,1):[],f=0,g=d.length;g>f;f++)if(c=d[f])for(a in c)Y.call(c,a)&&(e=c[a],null!=b[a]&&"object"==typeof b[a]&&null!=e&&"object"==typeof e?v(b[a],e):b[a]=e);return b},q=function(a){var b,c,d,e,f;for(c=b=0,e=0,f=a.length;f>e;e++)d=a[e],c+=Math.abs(d),b++;return c/b},x=function(a,b){var c,d,e;if(null==a&&(a="options"),null==b&&(b=!0),e=document.querySelector("[data-pace-"+a+"]")){if(c=e.getAttribute("data-pace-"+a),!b)return c;try{return JSON.parse(c)}catch(f){return d=f,"undefined"!=typeof console&&null!==console?console.error("Error parsing inline pace options",d):void 0}}},g=function(){function a(){}return a.prototype.on=function(a,b,c,d){var e;return null==d&&(d=!1),null==this.bindings&&(this.bindings={}),null==(e=this.bindings)[a]&&(e[a]=[]),this.bindings[a].push({handler:b,ctx:c,once:d})},a.prototype.once=function(a,b,c){return this.on(a,b,c,!0)},a.prototype.off=function(a,b){var c,d,e;if(null!=(null!=(d=this.bindings)?d[a]:void 0)){if(null==b)return delete this.bindings[a];for(c=0,e=[];c<this.bindings[a].length;)e.push(this.bindings[a][c].handler===b?this.bindings[a].splice(c,1):c++);return e}},a.prototype.trigger=function(){var a,b,c,d,e,f,g,h,i;if(c=arguments[0],a=2<=arguments.length?X.call(arguments,1):[],null!=(g=this.bindings)?g[c]:void 0){for(e=0,i=[];e<this.bindings[c].length;)h=this.bindings[c][e],d=h.handler,b=h.ctx,f=h.once,d.apply(null!=b?b:this,a),i.push(f?this.bindings[c].splice(e,1):e++);return i}},a}(),j=window.Pace||{},window.Pace=j,v(j,g.prototype),D=j.options=v({},u,window.paceOptions,x()),U=["ajax","document","eventLag","elements"],Q=0,S=U.length;S>Q;Q++)K=U[Q],D[K]===!0&&(D[K]=u[K]);i=function(a){function b(){return V=b.__super__.constructor.apply(this,arguments)}return Z(b,a),b}(Error),b=function(){function a(){this.progress=0}return a.prototype.getElement=function(){var a;if(null==this.el){if(a=document.querySelector(D.target),!a)throw new i;this.el=document.createElement("div"),this.el.className="pace pace-active",document.body.className=document.body.className.replace(/pace-done/g,""),document.body.className+=" pace-running",this.el.innerHTML='<div class="pace-progress">\n  <div class="pace-progress-inner"></div>\n</div>\n<div class="pace-activity"></div>',null!=a.firstChild?a.insertBefore(this.el,a.firstChild):a.appendChild(this.el)}return this.el},a.prototype.finish=function(){var a;return a=this.getElement(),a.className=a.className.replace("pace-active",""),a.className+=" pace-inactive",document.body.className=document.body.className.replace("pace-running",""),document.body.className+=" pace-done"},a.prototype.update=function(a){return this.progress=a,this.render()},a.prototype.destroy=function(){try{this.getElement().parentNode.removeChild(this.getElement())}catch(a){i=a}return this.el=void 0},a.prototype.render=function(){var a,b,c,d,e,f,g;if(null==document.querySelector(D.target))return!1;for(a=this.getElement(),d="translate3d("+this.progress+"%, 0, 0)",g=["webkitTransform","msTransform","transform"],e=0,f=g.length;f>e;e++)b=g[e],a.children[0].style[b]=d;return(!this.lastRenderedProgress||this.lastRenderedProgress|0!==this.progress|0)&&(a.children[0].setAttribute("data-progress-text",""+(0|this.progress)+"%"),this.progress>=100?c="99":(c=this.progress<10?"0":"",c+=0|this.progress),a.children[0].setAttribute("data-progress",""+c)),this.lastRenderedProgress=this.progress},a.prototype.done=function(){return this.progress>=100},a}(),h=function(){function a(){this.bindings={}}return a.prototype.trigger=function(a,b){var c,d,e,f,g;if(null!=this.bindings[a]){for(f=this.bindings[a],g=[],d=0,e=f.length;e>d;d++)c=f[d],g.push(c.call(this,b));return g}},a.prototype.on=function(a,b){var c;return null==(c=this.bindings)[a]&&(c[a]=[]),this.bindings[a].push(b)},a}(),P=window.XMLHttpRequest,O=window.XDomainRequest,N=window.WebSocket,w=function(a,b){var c,d,e,f;f=[];for(d in b.prototype)try{e=b.prototype[d],f.push(null==a[d]&&"function"!=typeof e?a[d]=e:void 0)}catch(g){c=g}return f},A=[],j.ignore=function(){var a,b,c;return b=arguments[0],a=2<=arguments.length?X.call(arguments,1):[],A.unshift("ignore"),c=b.apply(null,a),A.shift(),c},j.track=function(){var a,b,c;return b=arguments[0],a=2<=arguments.length?X.call(arguments,1):[],A.unshift("track"),c=b.apply(null,a),A.shift(),c},J=function(a){var b;if(null==a&&(a="GET"),"track"===A[0])return"force";if(!A.length&&D.ajax){if("socket"===a&&D.ajax.trackWebSockets)return!0;if(b=a.toUpperCase(),$.call(D.ajax.trackMethods,b)>=0)return!0}return!1},k=function(a){function b(){var a,c=this;b.__super__.constructor.apply(this,arguments),a=function(a){var b;return b=a.open,a.open=function(d,e){return J(d)&&c.trigger("request",{type:d,url:e,request:a}),b.apply(a,arguments)}},window.XMLHttpRequest=function(b){var c;return c=new P(b),a(c),c};try{w(window.XMLHttpRequest,P)}catch(d){}if(null!=O){window.XDomainRequest=function(){var b;return b=new O,a(b),b};try{w(window.XDomainRequest,O)}catch(d){}}if(null!=N&&D.ajax.trackWebSockets){window.WebSocket=function(a,b){var d;return d=null!=b?new N(a,b):new N(a),J("socket")&&c.trigger("request",{type:"socket",url:a,protocols:b,request:d}),d};try{w(window.WebSocket,N)}catch(d){}}}return Z(b,a),b}(h),R=null,y=function(){return null==R&&(R=new k),R},I=function(a){var b,c,d,e;for(e=D.ajax.ignoreURLs,c=0,d=e.length;d>c;c++)if(b=e[c],"string"==typeof b){if(-1!==a.indexOf(b))return!0}else if(b.test(a))return!0;return!1},y().on("request",function(b){var c,d,e,f,g;return f=b.type,e=b.request,g=b.url,I(g)?void 0:j.running||D.restartOnRequestAfter===!1&&"force"!==J(f)?void 0:(d=arguments,c=D.restartOnRequestAfter||0,"boolean"==typeof c&&(c=0),setTimeout(function(){var b,c,g,h,i,k;if(b="socket"===f?e.readyState<2:0<(h=e.readyState)&&4>h){for(j.restart(),i=j.sources,k=[],c=0,g=i.length;g>c;c++){if(K=i[c],K instanceof a){K.watch.apply(K,d);break}k.push(void 0)}return k}},c))}),a=function(){function a(){var a=this;this.elements=[],y().on("request",function(){return a.watch.apply(a,arguments)})}return a.prototype.watch=function(a){var b,c,d,e;return d=a.type,b=a.request,e=a.url,I(e)?void 0:(c="socket"===d?new n(b):new o(b),this.elements.push(c))},a}(),o=function(){function a(a){var b,c,d,e,f,g,h=this;if(this.progress=0,null!=window.ProgressEvent)for(c=null,a.addEventListener("progress",function(a){return h.progress=a.lengthComputable?100*a.loaded/a.total:h.progress+(100-h.progress)/2},!1),g=["load","abort","timeout","error"],d=0,e=g.length;e>d;d++)b=g[d],a.addEventListener(b,function(){return h.progress=100},!1);else f=a.onreadystatechange,a.onreadystatechange=function(){var b;return 0===(b=a.readyState)||4===b?h.progress=100:3===a.readyState&&(h.progress=50),"function"==typeof f?f.apply(null,arguments):void 0}}return a}(),n=function(){function a(a){var b,c,d,e,f=this;for(this.progress=0,e=["error","open"],c=0,d=e.length;d>c;c++)b=e[c],a.addEventListener(b,function(){return f.progress=100},!1)}return a}(),d=function(){function a(a){var b,c,d,f;for(null==a&&(a={}),this.elements=[],null==a.selectors&&(a.selectors=[]),f=a.selectors,c=0,d=f.length;d>c;c++)b=f[c],this.elements.push(new e(b))}return a}(),e=function(){function a(a){this.selector=a,this.progress=0,this.check()}return a.prototype.check=function(){var a=this;return document.querySelector(this.selector)?this.done():setTimeout(function(){return a.check()},D.elements.checkInterval)},a.prototype.done=function(){return this.progress=100},a}(),c=function(){function a(){var a,b,c=this;this.progress=null!=(b=this.states[document.readyState])?b:100,a=document.onreadystatechange,document.onreadystatechange=function(){return null!=c.states[document.readyState]&&(c.progress=c.states[document.readyState]),"function"==typeof a?a.apply(null,arguments):void 0}}return a.prototype.states={loading:0,interactive:50,complete:100},a}(),f=function(){function a(){var a,b,c,d,e,f=this;this.progress=0,a=0,e=[],d=0,c=C(),b=setInterval(function(){var g;return g=C()-c-50,c=C(),e.push(g),e.length>D.eventLag.sampleCount&&e.shift(),a=q(e),++d>=D.eventLag.minSamples&&a<D.eventLag.lagThreshold?(f.progress=100,clearInterval(b)):f.progress=100*(3/(a+3))},50)}return a}(),m=function(){function a(a){this.source=a,this.last=this.sinceLastUpdate=0,this.rate=D.initialRate,this.catchup=0,this.progress=this.lastProgress=0,null!=this.source&&(this.progress=F(this.source,"progress"))}return a.prototype.tick=function(a,b){var c;return null==b&&(b=F(this.source,"progress")),b>=100&&(this.done=!0),b===this.last?this.sinceLastUpdate+=a:(this.sinceLastUpdate&&(this.rate=(b-this.last)/this.sinceLastUpdate),this.catchup=(b-this.progress)/D.catchupTime,this.sinceLastUpdate=0,this.last=b),b>this.progress&&(this.progress+=this.catchup*a),c=1-Math.pow(this.progress/100,D.easeFactor),this.progress+=c*this.rate*a,this.progress=Math.min(this.lastProgress+D.maxProgressPerFrame,this.progress),this.progress=Math.max(0,this.progress),this.progress=Math.min(100,this.progress),this.lastProgress=this.progress,this.progress},a}(),L=null,H=null,r=null,M=null,p=null,s=null,j.running=!1,z=function(){return D.restartOnPushState?j.restart():void 0},null!=window.history.pushState&&(T=window.history.pushState,window.history.pushState=function(){return z(),T.apply(window.history,arguments)}),null!=window.history.replaceState&&(W=window.history.replaceState,window.history.replaceState=function(){return z(),W.apply(window.history,arguments)}),l={ajax:a,elements:d,document:c,eventLag:f},(B=function(){var a,c,d,e,f,g,h,i;for(j.sources=L=[],g=["ajax","elements","document","eventLag"],c=0,e=g.length;e>c;c++)a=g[c],D[a]!==!1&&L.push(new l[a](D[a]));for(i=null!=(h=D.extraSources)?h:[],d=0,f=i.length;f>d;d++)K=i[d],L.push(new K(D));return j.bar=r=new b,H=[],M=new m})(),j.stop=function(){return j.trigger("stop"),j.running=!1,r.destroy(),s=!0,null!=p&&("function"==typeof t&&t(p),p=null),B()},j.restart=function(){return j.trigger("restart"),j.stop(),j.start()},j.go=function(){var a;return j.running=!0,r.render(),a=C(),s=!1,p=G(function(b,c){var d,e,f,g,h,i,k,l,n,o,p,q,t,u,v,w;for(l=100-r.progress,e=p=0,f=!0,i=q=0,u=L.length;u>q;i=++q)for(K=L[i],o=null!=H[i]?H[i]:H[i]=[],h=null!=(w=K.elements)?w:[K],k=t=0,v=h.length;v>t;k=++t)g=h[k],n=null!=o[k]?o[k]:o[k]=new m(g),f&=n.done,n.done||(e++,p+=n.tick(b));return d=p/e,r.update(M.tick(b,d)),r.done()||f||s?(r.update(100),j.trigger("done"),setTimeout(function(){return r.finish(),j.running=!1,j.trigger("hide")},Math.max(D.ghostTime,Math.max(D.minTime-(C()-a),0)))):c()})},j.start=function(a){v(D,a),j.running=!0;try{r.render()}catch(b){i=b}return document.querySelector(".pace")?(j.trigger("start"),j.go()):setTimeout(j.start,50)},"function"==typeof define&&define.amd?define(function(){return j}):"object"==typeof exports?module.exports=j:D.startOnPageLoad&&j.start()}).call(this);

function addCommas(nStr)
{
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

