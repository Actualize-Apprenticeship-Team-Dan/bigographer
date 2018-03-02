/* global Vue */
document.addEventListener("DOMContentLoaded", function(event) { 
  Vue.component('line-chart', {
    extends: VueChartJs.Line,
    mixins: [VueChartJs.mixins.reactiveProp],
    props: ['chartData', 'options'],
    mounted () {
      this.renderChart(this.chartData, this.options)
    }
    
  })

  var app = new Vue({
    el: '#app',
    data: {
      options: {responsive: true, maintainAspectRatio: false},
      message: 'Submit Ruby Code Below',
      codes: [''],
      colors: ['#f87979'],
      results: [],
      chartData: {
        
      }
    },
    mounted: function() {
      var url = window.location.pathname.slice(1);
      if (url) {
        this.getCode(url);
      }
    },
    methods: {
      analyzeCode: function() {
        var that = this;
        Rails.ajax({
          url: "/api/v1/code",
          type: "POST",
          data: `codes=${this.codes}`,
          success: function(data) {
            this.results = data.results;
            this.chartData = {
              labels: data.results[0].map(point => point.x), 
              datasets: data.results.map(function(result, index) {
                console.log(index);
                return {
                  label: 'Number of steps',
                  borderColor: that.colors[index],
                  backgroundColor: that.colors[index],
                  data: result,
                  fill: false,
                  lineTension: 1,
                  cubicInterpolationMode: 'monotone'
                };
              })
            };
          }.bind(this)
        });
      },
      getCode: function(url){
        var that = this;
        Rails.ajax({
          url: "/api/v1/" + url,
          type: "GET",
          success: function(response) {

            that.codes = response;
            console.log(that.codes);
          }
        });
      },
      addCodeBox: function() {
        this.codes.push('');
        var rgb = [];
        for (var i = 0; i < 3; i++) {
          rgb.push(Math.floor(Math.random() * 255));
        }
        this.colors.push('rgb('+ rgb.join(',') +')');
      },
      saveCode: function() {
        if (!this.codes.length) {
          return;
        }
        Rails.ajax({
          url: "/api/v1/save",
          type: "POST",
          data: $.param({codes: this.codes}),
          success: function(response) {
            console.log(response);
            window.history.pushState('', 'Title of the page', response);
          }
        });
      },

    },
    computed: {

    }
  });
});