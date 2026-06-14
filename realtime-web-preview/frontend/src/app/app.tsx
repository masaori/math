import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import type { ReactElement } from 'react'
import { DocumentViewPage } from '../pages/document-view'

const queryClient = new QueryClient({
  defaultOptions: {
    queries: { retry: false, refetchOnWindowFocus: false },
  },
})

export const App = (): ReactElement => (
  <QueryClientProvider client={queryClient}>
    <DocumentViewPage />
  </QueryClientProvider>
)
