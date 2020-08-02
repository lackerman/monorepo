const requestOptions: RequestInit = {
  mode: 'cors',
  cache: 'no-cache',
  headers: {
    'Content-Type': 'application/json'
  },

}

export class RequestError extends Error {
  statusCode: number

  constructor(message: string, statusCode: number) {
    super(message);
    this.statusCode = statusCode;
  }
}

export async function get<T>(url: string): Promise<T> {
  const response = await fetch(url, requestOptions)
  if (!response.ok) {
    throw new RequestError(`Failed to perform 'GET' request to '${url}'`, response.status)
  }
  return await response.json() as Promise<T>
}

export async function post<RequestType, ResponseType>(url: string, body: RequestType): Promise<ResponseType> {
  const response = await fetch(url, {...requestOptions, method: 'post', body: JSON.stringify(body)})
  if (!response.ok) {
    throw new RequestError(`Failed to perform 'POST' request to '${url}'`, response.status)
  }
  return await response.json() as Promise<ResponseType>
}

export async function remove<T>(url: string): Promise<void> {
  const response = await fetch(url, {...requestOptions, method: 'delete'})
  if (!response.ok) {
    throw new RequestError(`Failed to perform 'POST' request to '${url}'`, response.status)
  }
  return Promise.resolve()
}
