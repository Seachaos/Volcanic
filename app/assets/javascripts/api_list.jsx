


var ApiListActionButton = React.createClass({
	render: function(){
		var name = 'View';
		var data = this.props.data;
		var url = data.path;
		var url_edit = root_url + 'api_list/edit/'+ data.id
		var url_copy = root_url + 'api_list/copy/'+ data.id
		
		return (<div className="btn-group" >
			<a href={url} className="btn btn-default" target="_blank" >{name}</a>
			<a href={url_copy} className="btn btn-default" >Copy</a>
			<a href={url_edit} className="btn btn-default" >Edit</a>
			<a href="" className="btn btn-default" disabled="disabled" >Delete</a>
		</div>)
	}
});

var ApiListTableRow = React.createClass({
	render: function(){
		var data = this.props.data
		return (
			<tr className="table-striped" >
				<td>{data.name}</td>
				<td>{data.path}</td>
				<td><ApiListActionButton data={data} /></td>
			</tr>
		)
	}
});

var ApiListTableView = React.createClass({
	render: function(){
		var rows = this.props.datas.map( function(data){
			if(data.header){
				var tds = data.labels.map(function(label){
					return <td>{label}</td>
				});
				return <tr>{tds}</tr>
			}
			return <ApiListTableRow data={data} />
		});
		return (<table className="table" >
			{rows}
		</table>)
	}
})

// --------- ApiResponseReplacement ----------
var ApiResponseReplacementCreateRule = React.createClass({
	render : function(){
		return (<a className="btn btn-default" onClick={this.props.onClick} >Create New Rule</a>);
	}
});
var ApiResponseReplacementSelectBox = React.createClass({
	render : function(){
		var options = [];
		var name = this.props.name;
		for(i in this.props.options){
			var key = i, value = this.props.options[i];
			var rkey = name +'_'+key;
			options.push((<option value={key} key={rkey} >{value}</option>));
		}
		return (<span>
			<select className="" name={name} >{options}</select>
		</span>)
	}
});
var ApiResponseReplacementRuleView = React.createClass({
	render : function(){
		return (<div>
				<ApiResponseReplacementSelectBox name="if" options={{
					"if":"If",
					"not_if":"Not If"
				}} />
				Params( <input type="text" value="name" /> )
				<ApiResponseReplacementSelectBox name="if" options={{
					"contain":"contain",
					"prefix":"prefix",
					"suffix":"suffix"
				}} />
				<input type="text" value="value" />
				then
				<ApiResponseReplacementSelectBox name="if" options={{
					"relace":"relace",
					"delete":"delete",
					"add":"add"
				}} />
				response variable 
				<input type="text" value="response_name" /> and value is
				<input type="text" value="response_value" />
			</div>)
	}
});
var ApiResponseReplacementEditor = React.createClass({
	getInitialState : function(){
		return {
			rules : {}
		};
	},
	handleClickCreateNewRule : function(){
		var rules = this.state.rules;
		rules[uuid()] = {};
		this.setState({
			rules : rules
		});
	},
	render: function(){
		var ruleViews = []
		for(i in this.state.rules){
			var rule = this.state.rules[i];
			ruleViews.push(React.createElement(ApiResponseReplacementRuleView, {
				key : i,
				rule : rule
			}))
		}
		return (<div>
			{ruleViews}
			<ApiResponseReplacementCreateRule onClick={this.handleClickCreateNewRule} />
		</div>);
	}
});