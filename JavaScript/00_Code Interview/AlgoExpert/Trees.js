class BinaryTree {
  constructor(value) {
    this.value = value;
    this.left = null;
    this.right = null;
  }
}

class BST {
  constructor(value) {
    this.value = value;
    this.left = null;
    this.right = null;
  }
}

class Node {
  constructor(name) {
    this.name = name;
    this.children = [];
  }
  
  addChild(name) {
    this.children.push(new Node(name));
    return this;
  }
}

class LinkedList {
  constructor(value) {
    this.value = value;
    this.next = null;
  }
  
  printLink() {
	  var string = this.value;
	  var next = this.next;
	  while(next !== null) {
		  string += " -> " + next.value ;
		  next = next.next;
	  }
	  return string;
  }
}


