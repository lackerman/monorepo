import React, {ChangeEvent, FunctionComponent, MouseEvent} from 'react';

export interface Bookmark {
  id: string
  url: string
  title: string
  description: string
}

type DeleteHandler = (id: string) => ((event: MouseEvent<HTMLButtonElement>) => void)

type Props = {
  bookmarks: Array<Bookmark>
  deleteHandler: DeleteHandler
}

export const Bookmarks: FunctionComponent<Props> = ({bookmarks, deleteHandler}) => {
  return <ul>
    {bookmarks.map(bookmark => (
      <BookmarkElement key={bookmark.id} bookmark={bookmark} deleteHandler={deleteHandler}/>))}
  </ul>
}


type BookmarkProps = {
  bookmark: Bookmark
  deleteHandler: DeleteHandler
}

const BookmarkElement: FunctionComponent<BookmarkProps> = ({bookmark, deleteHandler}) => {
  const {id, url, title, description} = bookmark;
  const onDelete = deleteHandler(id);
  return <div className="section">
    <div className="container">
      <div className="card">
        <header className="card-header">
          <p className="card-header-title"><a href={url}>{title}</a></p>
          <a href="#" className="card-header-icon" aria-label="more options">
      <span className="icon">
        <i className="fas fa-angle-down" aria-hidden="true"/>
      </span>
          </a>
        </header>
        <div className="card-content">
          <div className="content">
            {description}
          </div>
        </div>
        <footer className="card-footer">
          <button className="is-small button card-footer-item">Edit</button>
          <button className="is-small button card-footer-item" onClick={onDelete}><span
            className="icon is-small"><i
            className="fas fa-trash-alt"/></span></button>
        </footer>
      </div>
    </div>
  </div>
}

type AdderProps = {
  url: string
  onChange: (event: ChangeEvent<HTMLInputElement>) => void
  onClick: (event: MouseEvent<HTMLButtonElement>) => void
}

export const Adder: FunctionComponent<AdderProps> = ({url, onChange, onClick}) => {
  return <div className="field has-addons">
    <div className="control">
      <input className="input" type="text" placeholder="Enter the URL" value={url} onChange={onChange}/>
    </div>
    <div className="control">
      <button onClick={onClick} className="button is-info">
        Add Bookmark
      </button>
    </div>
  </div>
}