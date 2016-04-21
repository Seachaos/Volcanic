


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

var ApiResponseReplacementEditor = React.createClass({
	render: function(){
		return (<h1>Working</h1>);
	}
});