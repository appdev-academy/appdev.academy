import PropTypes from 'prop-types'
import React from 'react'
import { findDOMNode } from 'react-dom'
import { Link } from 'react-router-dom'
import { DragSource, DropTarget } from 'react-dnd'

import GreenButton from '../Buttons/Green'
import OrangeButton from '../Buttons/Orange'
import RedButton from '../Buttons/Red'

const style = {
  border: '1px dashed gray',
  padding: '0.5rem 1rem',
  marginBottom: '.5rem',
  backgroundColor: 'white',
  cursor: 'move'
}

const cardSource = {
  beginDrag(props) {
    return {
      id: props.id,
      index: props.index
    }
  },
  
  endDrag(props, monitor, component) {
    if (monitor.didDrop()) {
      let startIndex = props.index
      let dropIndex = monitor.getItem().index
      props.moveRow(startIndex, dropIndex)
    }
  }
}

const cardTarget = {
  hover(props, monitor, component) {
    // Note: we're mutating the monitor item here!
    // Generally it's better to avoid mutations,
    // but it's good here for the sake of performance
    // to avoid expensive index searches.
    monitor.getItem().index = props.index
  }
}

@DropTarget(
  "EMPLOYEE_ROW",
  cardTarget,
  connect => ({
    connectDropTarget: connect.dropTarget()
  })
)
@DragSource(
  "EMPLOYEE_ROW",
  cardSource,
  (connect, monitor) => ({
    connectDragSource: connect.dragSource(),
    isDragging: monitor.isDragging()
  })
)
export default class TableRow extends React.Component {
  
  static propTypes = {
    connectDragSource: PropTypes.func.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    index: PropTypes.number.isRequired,
    isDragging: PropTypes.bool.isRequired,
    id: PropTypes.any.isRequired,
    text: PropTypes.string.isRequired,
    moveRow: PropTypes.func.isRequired
  }
  
  render() {
    const { text, isDragging, connectDragSource, connectDropTarget } = this.props
    const opacity = isDragging ? 0 : 1
    
    let employee = this.props.employee
    let publishButton = <GreenButton title='Publish' onClick={ () => { this.props.publishButtonClick(employee.id) }} />
    if (employee.published) {
      publishButton = <OrangeButton title='Hide' onClick={ () => { this.props.hideButtonClick(employee.id) }} />
    }
    
    return connectDragSource(connectDropTarget(
      <tr key={ employee.id }>
        <td>{ employee.id }</td>
        <td>{ employee.title }</td>
        <td>{ employee.first_name }</td>
        <td>{ employee.last_name }</td>
        <td><img className='profile-picture' src={ employee.profile_picture } /></td>
        <td>{ employee.position }</td>
        <td className='actions left'>
          <Link className='button blue' to={ `/admin/employees/${employee.id}` }>Show</Link>
          <Link className='button green' to={ `/admin/employees/${employee.id}/edit` }>Edit</Link>
          <RedButton title='Delete' onClick={ () => { this.props.deleteButtonClick(employee) }} />
        </td>
        <td className='actions left'>
          { publishButton }
        </td>
      </tr>
    ))
  }
}
