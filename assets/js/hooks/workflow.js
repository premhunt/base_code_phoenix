let WorkflowBuilder = {
    mounted() {
        this.handleEvent("update_form", (data) => {
		console.log("load form called");
            document.getElementById("form-container").innerHTML = data.form;
        });
        let instance = jsPlumb.getInstance({
            Connector: ["Flowchart"],
            PaintStyle: { stroke: "#666", strokeWidth: 2 },
            Endpoint: ["Dot", { radius: 5 }],
            Container: this.el
        });

        this.instance = instance; // Store instance globally for reuse

        // Enable dragging for all nodes
        this.enableDragging();

        // Initialize existing nodes
        this.initializeNodes();

        console.log("Workflow Builder initialized!");
    },

    enableDragging() {
        let nodes = document.querySelectorAll(".node");
        nodes.forEach(node => {
            this.instance.draggable(node, { grid: [20, 20] });

            // Click event to trigger form loading
            node.addEventListener("click", () => {
                let nodeType = node.getAttribute("data-type");
                this.pushEvent("load_form", { node_id: node.id, type: nodeType });
            });
        });
    },

    initializeNodes() {
        let nodes = document.querySelectorAll(".node");
        nodes.forEach(node => {
            let nodeId = node.id;
            let nodeType = node.getAttribute("data-type");

            if (nodeType === "source") {
                // Source node should only have an outgoing connection
                this.instance.addEndpoint(nodeId, { anchors: "BottomCenter" }, { isSource: true });
            } else {
                // Other nodes can have incoming and outgoing connections
                this.instance.addEndpoint(nodeId, { anchors: "TopCenter" }, { isTarget: true });
                this.instance.addEndpoint(nodeId, { anchors: "BottomCenter" }, { isSource: true });
            }
        });
    },

    addNode(type) {
        let nodeId = `node-${type}-${Date.now()}`;
        let node = document.createElement("div");
        node.id = nodeId;
        node.className = `node ${type}`;
        node.setAttribute("data-type", type);
        node.innerText = type.charAt(0).toUpperCase() + type.slice(1);

        document.getElementById("workflow-container").appendChild(node);
        this.instance.draggable(node, { grid: [20, 20] });

        this.initializeNodes(); // Attach endpoints
    }
};

export default WorkflowBuilder;

/*let WorkflowBuilder = {
    mounted() {
        let instance = jsPlumb.getInstance({
            Connector: ["Flowchart"],
            PaintStyle: { stroke: "#666", strokeWidth: 2 },
            Endpoint: ["Dot", { radius: 5 }],
            Container: this.el
        });

        this.instance = instance; // Store instance globally for reuse

        // Enable dragging for all nodes
        this.enableDragging();

        // Initialize existing nodes
        this.initializeNodes();

        console.log("Workflow Builder initialized!");
    },

    enableDragging() {
        let nodes = document.querySelectorAll(".node");
        nodes.forEach(node => {
            this.instance.draggable(node, { grid: [20, 20] });

            // Click event to trigger form loading
            node.addEventListener("click", () => {
                let nodeType = node.getAttribute("data-type");
                this.pushEvent("load_form", { node_id: node.id, type: nodeType });
            });
        });
    },

    initializeNodes() {
        let nodes = document.querySelectorAll(".node");
        nodes.forEach(node => {
            let nodeId = node.id;
            let nodeType = node.getAttribute("data-type");

            if (nodeType === "source") {
                this.instance.addEndpoint(nodeId, { anchors: "BottomCenter" }, { isSource: true });
            } else {
                this.instance.addEndpoint(nodeId, { anchors: "TopCenter" }, { isTarget: true });
                this.instance.addEndpoint(nodeId, { anchors: "BottomCenter" }, { isSource: true });
            }
        });
    },

    addNode(type) {
        let nodeId = `node-${type}-${Date.now()}`;
        let node = document.createElement("div");
        node.id = nodeId;
        node.className = `node ${type}`;
        node.setAttribute("data-type", type);
        node.innerText = type.charAt(0).toUpperCase() + type.slice(1);

        document.getElementById("workflow-container").appendChild(node);
        this.instance.draggable(node, { grid: [20, 20] });

        this.initializeNodes(); // Attach endpoints
    }
};

export default WorkflowBuilder;
*/
