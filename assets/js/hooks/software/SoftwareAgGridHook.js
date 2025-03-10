import BaseAgGridHook from '../base/BaseAgGridHook';

export default {
  ...BaseAgGridHook,
  mounted() {
    const config = {
      columnDefs: [
        { headerName: "ID", field: "id" },
        { 
          headerName: "Name", 
          field: "name",
          cellRenderer: params => {
            return `<a href="/software/${params.value.id}" class="text-blue-600 hover:text-blue-800">${params.value.name}</a>`
          }
        },
        { headerName: "Slug", field: "slug" },
        { headerName: "Last Updated", field: "last_updated" },
        { headerName: "Created At", field: "inserted_at" },
        { headerName: "Updated At", field: "updated_at" }
      ],
      rowData: JSON.parse(this.el.dataset.software || '[]')
    };

    this.setupGrid(config);
  }
}
