import * as _ from 'lodash';
import React, {ChangeEvent, Component, MouseEvent} from 'react'
import {Adder, Bookmark, Bookmarks} from './components/Bookmarks'
import {Warning} from './components/Warning'
import {get, post, remove, RequestError} from './lib/request'

const config = {
  'serverUrl': 'http://localhost:8080'
}

interface AppState {
  isLoaded: boolean
  error: string | null
  bookmarkUrl: string
  bookmarks: Array<Bookmark>
}

type AddBookmark = {
  url: string
}

export class App extends Component<{}, AppState> {
  constructor(props: {}) {
    super(props)
    this.state = {
      bookmarkUrl: '',
      isLoaded: false,
      bookmarks: [],
      error: null,
    }
  }

  componentDidMount = () => {
    this.getBookmarks()
  }

  getBookmarks = () => {
    get<Array<Bookmark>>(`${config.serverUrl}/bookmarks`)
      .then((bookmarks) => {
          this.setState({
            isLoaded: true,
            bookmarks
          })
        },
        (error: Error) => {
          this.setState({
            isLoaded: true,
            error: errorMessage(error)
          })
        })
  }

  addBookmark = (event: MouseEvent<HTMLButtonElement>) => {
    event.preventDefault()
    const {bookmarkUrl, bookmarks} = this.state
    post<AddBookmark, Bookmark>(`${config.serverUrl}/bookmarks`, {url: bookmarkUrl})
      .then(bookmark => {
          this.setState({bookmarks: [...bookmarks, bookmark]})
        },
        (error: Error) => {
          this.setState({error: errorMessage(error)})
        })
  }

  deleteBookmark(id: string): (event: MouseEvent<HTMLButtonElement>) => void {
    const {bookmarks} = this.state
    return (event: MouseEvent<HTMLButtonElement>) => {
      event.preventDefault()
      console.log(event.target)
      remove(`${config.serverUrl}/bookmarks/${id}`)
        .then(ignored => {
            this.setState({
              isLoaded: true,
              bookmarks: _.remove(bookmarks, (elem) => elem.id === id),
            })
          },
          (error: Error) => {
            this.setState({
              isLoaded: true,
              error: errorMessage(error)
            })
          })
    }
  }

  setBookmarkUrl = (event: ChangeEvent<HTMLInputElement>) => {
    this.setState({bookmarkUrl: event.target.value})
  }

  render() {
    const {error, isLoaded, bookmarkUrl, bookmarks} = this.state
    if (!isLoaded) {
      return <div>Loading...</div>
    } else {
      return (
        <div>
          {error ? <Warning message={error}/> : <span/>}
          <div className="App">
            <form>
              <Adder url={bookmarkUrl} onChange={this.setBookmarkUrl} onClick={this.addBookmark}/>
            </form>
            <Bookmarks bookmarks={bookmarks} deleteHandler={this.deleteBookmark} />
          </div>
        </div>
      )
    }
  }
}

const errorMessage = (error: Error) => {
  if (error instanceof RequestError) {
    return `Status Code: ${error.statusCode}. ${error.message}.`
  }
  return 'There was no response from the server. Try again'
}


