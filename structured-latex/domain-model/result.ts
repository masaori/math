/**
 * 想定内エラーの伝搬手段（docs/error-handling-strategy.md §1）。
 * throw では伝搬しない。呼び出し元に処理を強制するための判別共用体。
 */

export type Result<T, E> = { success: true; data: T } | { success: false; error: E }

export const ok = <T>(data: T): Result<T, never> => ({ success: true, data })

export const err = <E>(error: E): Result<never, E> => ({ success: false, error })

/**
 * 判別共用体の網羅性をコンパイル時に保証する（docs/architecture-overview.md 設計原則 1）。
 * 分岐を足し忘れると、この呼び出しが型エラーになる。
 */
export const assertNever = (value: never): never => {
  throw new Error(`unreachable: ${JSON.stringify(value)}`)
}
