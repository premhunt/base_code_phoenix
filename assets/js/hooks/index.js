import WorkflowBuilder from "./workflow";
import SoftwareAgGridHook from './software/SoftwareAgGridHook'

let Hooks = {}

Hooks.Focus = {
  mounted() {
    this.el.focus()
  }
}

Hooks.SoftwareAgGrid = SoftwareAgGridHook
Hooks.WorkflowBuilder = WorkflowBuilder;


export {Hooks}
