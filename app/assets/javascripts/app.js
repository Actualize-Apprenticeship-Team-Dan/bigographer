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
      bigO: '',
      chartData: {
        
      }
    },
    mounted: function() {

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
            this.bigO = data.bigO;
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
      addCodeBox: function() {
        this.codes.push('');
        var rgb = [];
        for (var i = 0; i < 3; i++) {
          rgb.push(Math.floor(Math.random() * 255));
        }
        this.colors.push('rgb('+ rgb.join(',') +')');
      }
    },
    computed: {

    }
  });
});