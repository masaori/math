export type Unsubscribe = () => void

/**
 * 入力ソースの変更監視（外部 domain: ファイルシステム）への gateway。
 * 変更が起きるたび onChange を呼ぶ購読を確立し、解除関数を返す。
 */
export interface SourceWatcherGateway {
  subscribe(onChange: () => void): Unsubscribe
}
