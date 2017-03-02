var BREWERIES = {};

BREWERIES.show = function(){
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function (index, brewery) {
        table.append('<tr>'
            +'<td>'+brewery['name']+'</td>' +
                '<td>'+brewery['year'].name + '</td>' +
                '<td>'+brewery['beerscount'].beerscount + '</td>' +
                '<td>'+brewery['retired'].retired  +'</td>' +
            '</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        return a.year.name - b.year.name;
    });
};

BREWERIES.sort_by_count = function(){
    BREWERIES.list.sort( function(a,b) {
        return a.beerscount.beerscount - b.beerscount.beerscount;
    });
};

BREWERIES.sort_by_activity = function(){
    BREWERIES.list.sort( function(a,b) {
        return 1;
    });
};


$(document).ready(function () {
    if ( $("#brewerytable").length>0 ) {


        $("#year").click(function (e) {
            console.log("year");
            BREWERIES.sort_by_year();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#name").click(function (e) {
            BREWERIES.sort_by_name();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#beerscount").click(function (e) {
            BREWERIES.sort_by_count();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#retired").click(function (e) {
            console.log("retired");
            BREWERIES.sort_by_activity();
            BREWERIES.show();
            e.preventDefault();
        });

        $.getJSON('breweries.json', function (breweries) {
            BREWERIES.list = breweries
           console.log(breweries);
            BREWERIES.show();
        });

    }
});