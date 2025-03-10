export default {
  setupGrid(config) {
    const defaultConfig = {
      pagination: true,
      paginationPageSize: 10,
      domLayout: 'autoHeight',
      defaultColDef: {
        flex: 1,
        minWidth: 100,
        filter: true,
        sortable: true,
        resizable: true
      },
      animateRows: true
    };

    const gridOptions = { ...defaultConfig, ...config };
    const gridDiv = document.querySelector(this.el.dataset.target || "#gridContainer");

	   this.gridApi  = agGrid.createGrid(gridDiv,gridOptions);
    
	  this.gridOptions = gridOptions;
  },

  updated() {
    if (this.gridOptions && this.el.dataset.rows) {
	    this.gridApi.setGridOption("rowData", JSON.parse(this.el.dataset.rows));
    }
  },

  destroyed() {
    if (this.gridOptions && this.gridOptions.api) {
	    //this.gridOptions.api.destroy();
	    this.gridApi.destroy();
    }
  }
}
