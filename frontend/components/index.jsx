var React = require('react');
var ImageUtils = require('../util/api_utils');
var ImageStore = require('../stores/image_store');
var Link = require('react-router').Link;

var React = require('react');

var ImageIndex = React.createClass({
	getInitialState: function() {
		return { images: ImageStore.all()};
	},

	componentDidMount: function() {
		ImageUtils.fetchImages();
		this.ImageStoreToken = ImageStore.addListener(this._onChange);
	},

	componentWillUnmount: function() {
		this.ImageStoreToken.remove();
	},

	_onChange: function () {
		this.setState({ images: ImageStore.all()});
	},

	render: function() {
		var images = this.state.images.map( function (image) {
			var uploader = (image.user ? image.user.username : "");
			var showUrl = "/images/" + image.id;
			return(
				<Link to={showUrl} key={image.id}>
					<div className='image-index-item'>
						<div>Image Id: {image.id}</div>
						<div>Uploader: {uploader}</div>
						<div>Title: {image.title}</div>
						<div>Description: {image.description}</div>

					</div>
				</Link>
			);
		});
		return (
			<div className='image-index group'>
				{images}
			</div>
		);
	}

});

module.exports = ImageIndex;
