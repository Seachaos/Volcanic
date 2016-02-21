

var APIListInput = React.createClass({
	render: function(){
		var name = this.props.name;
		var input_name = 'post['+name+']';
		return (
			<div className="form-group" >
				<label>{this.props.cname}</label>
				<input type="text" name={input_name} id={name} className="form-control" />
			</div>
		)
	}
});

var APIListCreateForm = React.createClass({
	render : function(){
		return (<div>
			<APIListInput cname="Name" name="name" />
			<APIListInput cname="Path" name="path" />
			<textarea className="form-control" rows="3" placeholder="Response"></textarea>
		</div>)
	}
});
