/**
 * Result 型（Discriminated Union）。
 * 想定内エラーは throw せずこの型で伝搬し、処理漏れをコンパイル時に検出させる。
 * （docs/_template/docs/error-handling-strategy.md）
 */
export type Result<T, E> = { success: true; data: T } | { success: false; error: E }

export const ok = <T>(data: T): Result<T, never> => ({ success: true, data })

export const err = <E>(error: E): Result<never, E> => ({ success: false, error })

/** Discriminated Union の網羅性をコンパイル時に保証する。 */
export const assertNever = (value: never): never => {
  throw new Error(`Unexpected value: ${JSON.stringify(value)}`)
}
