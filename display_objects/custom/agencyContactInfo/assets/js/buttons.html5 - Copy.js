(function(g) {
    "function" === typeof define && define.amd ? define(["jquery", "datatables.net", "datatables.net-buttons"], function(d) {
        return g(d, window, document)
    }) : "object" === typeof exports ? module.exports = function(d, f) {
        d || (d = window);
        if (!f || !f.fn.dataTable) f = require("datatables.net")(d, f).$;
        f.fn.dataTable.Buttons || require("datatables.net-buttons")(d, f);
        return g(f, d, d.document)
    } : g(jQuery, window, document)
})(function(g, d, f, k) {
    var l = g.fn.dataTable,
        j;
    if ("undefined" !== typeof navigator && /MSIE [1-9]\./.test(navigator.userAgent)) j =
        void 0;
    else {
        var x = d.document,
            q = x.createElementNS("http://www.w3.org/1999/xhtml", "a"),
            E = "download" in q,
            r = d.webkitRequestFileSystem,
            y = d.requestFileSystem || r || d.mozRequestFileSystem,
            F = function(a) {
                (d.setImmediate || d.setTimeout)(function() {
                    throw a;
                }, 0)
            },
            s = 0,
            t = function(a) {
                var b = function() {
                    "string" === typeof a ? (d.URL || d.webkitURL || d).revokeObjectURL(a) : a.remove()
                };
                d.chrome ? b() : setTimeout(b, 500)
            },
            u = function(a, b, e) {
                for (var b = [].concat(b), c = b.length; c--;) {
                    var d = a["on" + b[c]];
                    if ("function" === typeof d) try {
                        d.call(a,
                            e || a)
                    } catch (i) {
                        F(i)
                    }
                }
            },
            A = function(a) {
                return /^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(a.type) ? new Blob(["﻿", a], {
                    type: a.type
                }) : a
            },
            B = function(a, b) {
                var a = A(a),
                    e = this,
                    c = a.type,
                    z = !1,
                    i, g, m = function() {
                        u(e, ["writestart", "progress", "write", "writeend"])
                    },
                    o = function() {
                        if (z || !i) i = (d.URL || d.webkitURL || d).createObjectURL(a);
                        g ? g.location.href = i : d.open(i, "_blank") === k && "undefined" !== typeof safari && (d.location.href = i);
                        e.readyState = e.DONE;
                        m();
                        t(i)
                    },
                    n = function(a) {
                        return function() {
                            if (e.readyState !==
                                e.DONE) return a.apply(this, arguments)
                        }
                    },
                    f = {
                        create: !0,
                        exclusive: !1
                    },
                    h;
                e.readyState = e.INIT;
                b || (b = "download");
                if (E) i = (d.URL || d.webkitURL || d).createObjectURL(a), q.href = i, q.download = b, c = x.createEvent("MouseEvents"), c.initMouseEvent("click", !0, !1, d, 0, 0, 0, 0, 0, !1, !1, !1, !1, 0, null), q.dispatchEvent(c), e.readyState = e.DONE, m(), t(i);
                else {
                    d.chrome && (c && "application/octet-stream" !== c) && (h = a.slice || a.webkitSlice, a = h.call(a, 0, a.size, "application/octet-stream"), z = !0);
                    r && "download" !== b && (b += ".download");
                    if ("application/octet-stream" ===
                        c || r) g = d;
                    y ? (s += a.size, y(d.TEMPORARY, s, n(function(c) {
                        c.root.getDirectory("saved", f, n(function(c) {
                            var d = function() {
                                c.getFile(b, f, n(function(b) {
                                        b.createWriter(n(function(c) {
                                            c.onwriteend = function(a) {
                                                g.location.href = b.toURL();
                                                e.readyState = e.DONE;
                                                u(e, "writeend", a);
                                                t(b)
                                            };
                                            c.onerror = function() {
                                                var a = c.error;
                                                a.code !== a.ABORT_ERR && o()
                                            };
                                            ["writestart", "progress", "write", "abort"].forEach(function(a) {
                                                c["on" + a] = e["on" + a]
                                            });
                                            c.write(a);
                                            e.abort = function() {
                                                c.abort();
                                                e.readyState = e.DONE
                                            };
                                            e.readyState = e.WRITING
                                        }), o)
                                    }),
                                    o)
                            };
                            c.getFile(b, {
                                create: false
                            }, n(function(a) {
                                a.remove();
                                d()
                            }), n(function(a) {
                                a.code === a.NOT_FOUND_ERR ? d() : o()
                            }))
                        }), o)
                    }), o)) : o()
                }
            },
            h = B.prototype;
        "undefined" !== typeof navigator && navigator.msSaveOrOpenBlob ? j = function(a, b) {
            return navigator.msSaveOrOpenBlob(A(a), b)
        } : (h.abort = function() {
            this.readyState = this.DONE;
            u(this, "abort")
        }, h.readyState = h.INIT = 0, h.WRITING = 1, h.DONE = 2, h.error = h.onwritestart = h.onprogress = h.onwrite = h.onabort = h.onerror = h.onwriteend = null, j = function(a, b) {
            return new B(a, b)
        })
    }
    var v = function(a,
            b) {
            var e = "*" === a.filename && "*" !== a.title && a.title !== k ? a.title : a.filename;
            "function" === typeof e && (e = e()); - 1 !== e.indexOf("*") && (e = e.replace("*", g("title").text()));
            e = e.replace(/[^a-zA-Z0-9_\u00A1-\uFFFF\.,\-_ !\(\)]/g, "");
            return b === k || !0 === b ? e + a.extension : e
        },
        G = function(a) {
            var b = "Sheet1";
            a.sheetName && (b = a.sheetName.replace(/[\[\]\*\/\\\?\:]/g, ""));
            return b
        },
        H = function(a) {
            a = a.title;
            "function" === typeof a && (a = a());
            return -1 !== a.indexOf("*") ? a.replace("*", g("title").text()) : a
        },
        w = function(a) {
            return a.newline ?
                a.newline : navigator.userAgent.match(/Windows/) ? "\r\n" : "\n"
        },
        C = function(a, b) {
            for (var e = w(b), c = a.buttons.exportData(b.exportOptions), d = b.fieldBoundary, i = b.fieldSeparator, g = RegExp(d, "g"), m = b.escapeChar !== k ? b.escapeChar : "\\", f = function(a) {
                    for (var b = "", c = 0, e = a.length; c < e; c++) 0 < c && (b += i), b += d ? d + ("" + a[c]).replace(g, m + d) + d : a[c];
                    return b
                }, n = b.header ? f(c.header) + e : "", h = b.footer && c.footer ? e + f(c.footer) : "", j = [], l = 0, p = c.body.length; l < p; l++) j.push(f(c.body[l]));
            return {
                str: n + j.join(e) + h,
                rows: j.length
            }
        },
        D = function() {
            return -1 !==
                navigator.userAgent.indexOf("Safari") && -1 === navigator.userAgent.indexOf("Chrome") && -1 === navigator.userAgent.indexOf("Opera")
        },
        p = {
            "_rels/.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\t<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>',
            "xl/_rels/workbook.xml.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\t<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>',
            "[Content_Types].xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\t<Default Extension="xml" ContentType="application/xml"/>\t<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\t<Default Extension="jpeg" ContentType="image/jpeg"/>\t<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>\t<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/></Types>',
            "xl/workbook.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\t<fileVersion appName="xl" lastEdited="5" lowestEdited="5" rupBuild="24816"/>\t<workbookPr showInkAnnotation="0" autoCompressPictures="0"/>\t<bookViews>\t\t<workbookView xWindow="0" yWindow="0" windowWidth="25600" windowHeight="19020" tabRatio="500"/>\t</bookViews>\t<sheets>\t\t<sheet name="__SHEET_NAME__" sheetId="1" r:id="rId1"/>\t</sheets></workbook>',
            "xl/worksheets/sheet1.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">\t<sheetData>\t\t__DATA__\t</sheetData></worksheet>'
        };
    l.ext.buttons.copyHtml5 = {
        className: "buttons-copy buttons-html5",
        text: function(a) {
            return a.i18n("buttons.copy", "Copy")
        },
        action: function(a, b, e, c) {
            var a = C(b, c),
                d = a.str,
                e = g("<div/>").css({
                    height: 1,
                    width: 1,
                    overflow: "hidden",
                    position: "fixed",
                    top: 0,
                    left: 0
                });
            c.customize && (d = c.customize(d, c));
            c = g("<textarea readonly/>").val(d).appendTo(e);
            if (f.queryCommandSupported("copy")) {
                e.appendTo("body");
                c[0].focus();
                c[0].select();
                try {
                    f.execCommand("copy");
                    e.remove();
                    b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), b.i18n("buttons.copySuccess", {
                        1: "Copied one row to clipboard",
                        _: "Copied %d rows to clipboard"
                    }, a.rows), 2E3);
                    return
                } catch (i) {}
            }
            a = g("<span>" + b.i18n("buttons.copyKeys", "Press <i>ctrl</i> or <i>⌘</i> + <i>C</i> to copy the table data<br>to your system clipboard.<br><br>To cancel, click this message or press escape.") + "</span>").append(e);
            b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), a, 0);
            c[0].focus();
            c[0].select();
            var h = g(a).closest(".dt-button-info"),
                m = function() {
                    h.off("click.buttons-copy");
                    g(f).off(".buttons-copy");
                    b.buttons.info(!1)
                };
            h.on("click.buttons-copy",
                m);
            g(f).on("keydown.buttons-copy", function(a) {
                27 === a.keyCode && m()
            }).on("copy.buttons-copy cut.buttons-copy", function() {
                m()
            })
        },
        exportOptions: {},
        fieldSeparator: "\t",
        fieldBoundary: "",
        header: !0,
        footer: !1
    };
    l.ext.buttons.csvHtml5 = {
        className: "btn btn-info btn-sm",
        available: function() {
            return d.FileReader !== k && d.Blob
        },
        text: function(a) {
            return a.i18n("buttons.csv", "CSV")
        },
        action: function(a, b, d, c) {
            w(c);
            a = C(b, c).str;
            b = c.charset;
            c.customize && (a = c.customize(a, c));
            !1 !== b ? (b || (b = f.characterSet || f.charset), b &&
                (b = ";charset=" + b)) : b = "";
            j(new Blob([a], {
                type: "text/csv" + b
            }), v(c))
        },
        filename: "*",
        extension: ".csv",
        exportOptions: {},
        fieldSeparator: ",",
        fieldBoundary: '"',
        escapeChar: '"',
        charset: null,
        header: !0,
        footer: !1
    };
    l.ext.buttons.excelHtml5 = {
        className: "buttons-excel buttons-html5",
        available: function() {
            return d.FileReader !== k && d.JSZip !== k && !D()
        },
        text: function(a) {
            return a.i18n("buttons.excel", "Excel")
        },
        action: function(a, b, e, c) {
            a = "";
            b = b.buttons.exportData(c.exportOptions);
            e = function(a) {
                for (var b = [], c = 0, d = a.length; c <
                    d; c++) {
                    if (null === a[c] || a[c] === k) a[c] = "";
                    b.push("number" === typeof a[c] || a[c].match && g.trim(a[c]).match(/^-?\d+(\.\d+)?$/) && "0" !== a[c].charAt(0) ? '<c t="n"><v>' + a[c] + "</v></c>" : '<c t="inlineStr"><is><t>' + (!a[c].replace ? a[c] : a[c].replace(/&(?!amp;)/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/[\x00-\x09\x0B\x0C\x0E-\x1F\x7F-\x9F]/g, "")) + "</t></is></c>")
                }
                return "<row>" + b.join("") + "</row>"
            };
            c.header && (a += e(b.header));
            for (var f = 0, i = b.body.length; f < i; f++) a += e(b.body[f]);
            c.footer && (a += e(b.footer));
            var b = new d.JSZip,
                e = b.folder("_rels"),
                f = b.folder("xl"),
                i = b.folder("xl/_rels"),
                h = b.folder("xl/worksheets");
            b.file("[Content_Types].xml", p["[Content_Types].xml"]);
            e.file(".rels", p["_rels/.rels"]);
            f.file("workbook.xml", p["xl/workbook.xml"].replace("__SHEET_NAME__", G(c)));
            i.file("workbook.xml.rels", p["xl/_rels/workbook.xml.rels"]);
            h.file("sheet1.xml", p["xl/worksheets/sheet1.xml"].replace("__DATA__", a));
            j(b.generate({
                    type: "blob",
                    mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                }),
                v(c))
        },
        filename: "*",
        extension: ".xlsx",
        exportOptions: {},
        header: !0,
        footer: !1
    };
    l.ext.buttons.pdfHtml5 = {
        className: "buttons-pdf buttons-html5",
        available: function() {
            return d.FileReader !== k && d.pdfMake
        },
        text: function(a) {
            return a.i18n("buttons.pdf", "PDF")
        },
        action: function(a, b, e, c) {
            w(c);
            a = b.buttons.exportData(c.exportOptions);
            b = [];
            c.header && b.push(g.map(a.header, function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: "tableHeader"
                }
            }));
            for (var f = 0, e = a.body.length; f < e; f++) b.push(g.map(a.body[f], function(a) {
                return {
                    text: "string" ===
                        typeof a ? a : a + "",
                    style: f % 2 ? "tableBodyEven" : "tableBodyOdd"
                }
            }));
            c.footer && b.push(g.map(a.footer, function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: "tableFooter"
                }
            }));
            a = {
                pageSize: c.pageSize,
                pageOrientation: c.orientation,
                content: [{
                    table: {
                        headerRows: 1,
                        body: b
                    },
                    layout: "noBorders"
                }],
                styles: {
                    tableHeader: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154",
                        alignment: "center"
                    },
                    tableBodyEven: {},
                    tableBodyOdd: {
                        fillColor: "#f3f3f3"
                    },
                    tableFooter: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154"
                    },
                    title: {
                        alignment: "center",
                        fontSize: 15
                    },
                    message: {}
                },
                defaultStyle: {
                    fontSize: 10
                }
            };
            c.message && a.content.unshift({
                text: c.message,
                style: "message",
                margin: [0, 0, 0, 12]
            });
            c.title && a.content.unshift({
                text: H(c, !1),
                style: "title",
                margin: [0, 0, 0, 12]
            });
            c.customize && c.customize(a, c);
            a = d.pdfMake.createPdf(a);
            "open" === c.download && !D() ? a.open() : a.getBuffer(function(a) {
                a = new Blob([a], {
                    type: "application/pdf"
                });
                j(a, v(c))
            })
        },
        title: "*",
        filename: "*",
        extension: ".pdf",
        exportOptions: {},
        orientation: "portrait",
        pageSize: "A4",
        header: !0,
        footer: !1,
        message: null,
        customize: null,
        download: "download"
    };
    return l.Buttons
});