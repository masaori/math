import type {
  SourceWatcherGateway,
  Unsubscribe,
} from '../interfaces/gateways/source-watcher-gateway.js'

/**
 * 入力ソースの変更を購読する。変更時に onChange が呼ばれる。
 */
export const subscribeToChanges = (
  watcher: SourceWatcherGateway,
  onChange: () => void,
): Unsubscribe => watcher.subscribe(onChange)
