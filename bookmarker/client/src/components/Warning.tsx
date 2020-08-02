import React, {FunctionComponent} from 'react';

type Props = {
  message: string
}
export const Warning: FunctionComponent<Props> = ({message}) => {
  return <article className="message is-warning">
    <div className="message-header">
      <p>Warning</p>
      <button className="delete" aria-label="delete"/>
    </div>
    <div className="message-body">
      {message}
    </div>
  </article>
}
