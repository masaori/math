import { type FSWatcher, existsSync, watch } from 'node:fs'
import type {
  SourceWatcherGateway,
  Unsubscribe,
} from '../../domain/interfaces/gateways/source-watcher-gateway.js'

/**
 * `fs.watch` で入力ソース dir を監視する adapter。
 * 複数の dir（例: 本体と参照用ノート）を同時に監視でき、
 * 連続して飛ぶ変更イベントはデバウンスして 1 回の onChange にまとめる。
 * 存在しない dir は監視対象から外す（任意ソースを許すため）。
 */
export class FsSourceWatcherGateway implements SourceWatcherGateway {
  private readonly sourceDirs: readonly string[]

  constructor(
    sourceDirs: readonly string[] | string,
    private readonly debounceMs = 150,
  ) {
    this.sourceDirs = typeof sourceDirs === 'string' ? [sourceDirs] : sourceDirs
  }

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

    const watchers: FSWatcher[] = []
    for (const dir of this.sourceDirs) {
      if (!existsSync(dir)) {
        continue
      }
      try {
        watchers.push(
          watch(dir, { recursive: true }, () => {
            trigger()
          }),
        )
      } catch {
        // recursive 非対応プラットフォーム向けのフォールバック（dir 直下のみ監視）。
        watchers.push(
          watch(dir, () => {
            trigger()
          }),
        )
      }
    }

    return () => {
      if (timer) {
        clearTimeout(timer)
      }
      for (const watcher of watchers) {
        watcher.close()
      }
    }
  }
}
