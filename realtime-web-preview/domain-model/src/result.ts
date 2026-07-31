/**
 * Result 型（Discriminated Union）。
 * 想定内エラーは throw せずこの型で伝搬し、処理漏れをコンパイル時に検出させる。
 * （docs/_template/docs/error-handling-strategy.md）
 *
 * 定義はシステム（`structured-latex/domain-model/result.ts`）が持つものを再輸出する。
 * システムの実行時スキーマが返す Result と本パッケージの Result が別物になると、
 * 境界のたびに詰め替えが必要になるため。
 */

export { assertNever, err, ok, type Result } from '@structured-latex/system/domain-model'
