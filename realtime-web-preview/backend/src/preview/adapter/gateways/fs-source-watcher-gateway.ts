import { type FSWatcher, watch } from 'node:fs'
import type {
  SourceWatcherGateway,
  Unsubscribe,
} from '../../domain/interfaces/gateways/source-watcher-gateway.js'

/**
 * `fs.watch` で入力ソース dir を監視する adapter。
 * 連続して飛ぶ変更イベントはデバウンスして 1 回の onChange にまとめる。
 */
export class FsSourceWatcherGateway implements SourceWatcherGateway {
  constructor(
    private readonly sourceDir: string,
    private readonly debounceMs = 150,
  ) {}

  subscribe(onChange: () => void): Unsubscribe {
    let timer: NodeJS.Timeout | undefined
    const trigger = (): void => {
      if (timer) {
        clearTimeout(timer)
      }
      timer = setTimeout(() => {
        onChange()
      }, this.debounceMs)
    }

    let watcher: FSWatcher
    try {
      watcher = watch(this.sourceDir, { recursive: true }, () => {
        trigger()
      })
    } catch {
      // recursive 非対応プラットフォーム向けのフォールバック（dir 直下のみ監視）。
      watcher = watch(this.sourceDir, () => {
        trigger()
      })
    }

    return () => {
      if (timer) {
        clearTimeout(timer)
      }
      watcher.close()
    }
  }
}
