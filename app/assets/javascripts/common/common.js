$(function() {
  $.extend({
    stringify: function stringify(obj) {
      /// <summary>
      /// オブジェクトをJSON文字列に変換する。
      /// ※JSON文字列をオブジェクトに変換する場合はjQuery標準のparseJSONを使う。
      ///
      /// json = $.stringify(obj);
      /// obj  = $.parseJSON(json);
      /// </summary>
      
      var t = typeof (obj);
      if (t != "object" || obj === null) {
        // simple data type
        if (t == "string") {
          obj = '"' + obj + '"';
        }
        return String(obj);
      }
      else {
        var n, v, json = [];
        var arr = (obj && $.isArray(obj));
          
        for (n in obj) {
          v = obj[n];
          t = typeof(v);
          if (obj.hasOwnProperty(n)) {
            if (t == "string") {
              v = '"' + v + '"';
            }
            else if (t == "object" && v !== null) {
              v = jQuery.stringify(v);
            }
            json.push((arr ? "" : '"' + n + '":') + String(v));
          }
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
      }
    }
  });
});
