import React from 'react'
import { Link } from 'react-router-dom'
import { inject, observer } from 'mobx-react'

import TableBody from './TableBody'

@inject('screencastsStore')
@observer
export default class Index extends React.Component {
  
  componentDidMount() {
    let topicID = this.props.match.params.topicID
    this.props.screencastsStore.fetchIndex(topicID)
  }
  
  moveScreencast(startIndex, dropIndex) {
    if (startIndex == dropIndex) {
      return
    }
    
    let topicID = this.props.match.params.topicID
    
    let screencastIDs = this.props.screencastsStore.screencasts.map((screencast) => screencast.id)
    let draggedScreencastID = screencastIDs[startIndex]
    screencastIDs.splice(startIndex, 1)
    screencastIDs.splice(dropIndex, 0, draggedScreencastID)
    // Sort Screencasts on server (assign position property to each Screencast according to order of IDs)
    this.props.screencastsStore.sort(topicID, screencastIDs)
  }
  
  render() {
    let topicID = this.props.match.params.topicID
    
    return (
      <div className='screencasts'>
        <h2 className='center'>Screencasts</h2>
        <Link className='button blue' to={ `/admin/topics/${topicID}/screencasts/new` }>+ New Screencast</Link>
        <br />
        <br />
        <table className='admin'>
          <thead>
            <tr>
              <td>ID</td>
              <td>Title</td>
              <td>Slug</td>
              <td>Position</td>
              <td>Actions</td>
              <td>Publish</td>
            </tr>
          </thead>
          <TableBody
            screencasts={ this.props.screencastsStore.screencasts }
            publishButtonClick={ (topicID, screencastID) => { this.props.screencastsStore.publish(topicID, screencastID) }}
            hideButtonClick={ (topicID, screencastID) => { this.props.screencastsStore.hide(topicID, screencastID) }}
            moveScreencast={ this.moveScreencast.bind(this) }
          />
        </table>
      </div>
    )
  }
}
