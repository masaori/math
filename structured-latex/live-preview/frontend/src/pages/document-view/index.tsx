import type { ReactElement } from 'react'
import { useDocument } from './fetch/use-document'
import { DocumentView } from './ui/document-view'

/** グルーコード: fetch hook → ui に props を素通しするだけ（処理を入れない）。 */
export const DocumentViewPage = (): ReactElement => {
  const model = useDocument()
  return <DocumentView {...model} />
}
