import React from 'react';
//import ReactDOM from 'react-dom';
import './LoginForm.css';

class LoginForm extends React.Component {
	
    constructor(props) {
      super(props);
      this.state = {username: '', passwd: ''};
    
      this.handleChange = this.handleChange.bind(this);
      this.handleSubmit = this.handleSubmit.bind(this);
    }
    
    handleChange  = (e, type) => { 
	    let inputValue = e.currentTarget.value
		if (type === "username") {
            this.setState({username: inputValue});
        }
		if (type === "password") {
            this.setState({passwd: inputValue});
        }
    }
    
    handleSubmit(event) {
      alert('information: ' + this.state.username + ' -- ' + this.state.passwd);
      event.preventDefault();
    }
  
    render(){
        return (
		  <div class="container">
            <form onSubmit={this.handleSubmit}>
			<div class="row">
			  <div class="col-25">
                <label for="username">用户名: </label>
			  </div>
			  <div class="col-75">
                <input type="text" id="username" name="username" value={this.state.username} onChange={(e) => this.handleChange(e, "username")} ></input>
			  </div>
		    </div>
			<div class="row">
			  <div class="col-25">
                <label for="password">密 码: </label>
			  </div>
			  <div class="col-75">
                <input type="text" id="password" name="password" value={this.state.passwd} onChange={(e) => this.handleChange(e, "password")} ></input>
			  </div>
			</div>
			<div class="row">
			  <div class="col-25" />
			  <div class="col-50">
                <input type="submit" value="登 录" />
			  </div>
			</div>
            </form>
		  </div>
        );
    }
}

export default LoginForm;
