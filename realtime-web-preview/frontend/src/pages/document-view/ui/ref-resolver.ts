import type { LabelIndex } from '@rwp/domain-model'
import { createContext, useContext } from 'react'

/**
 * ラベル → ブロック id の解決インデックスを描画ツリーへ配る Context。
 * ref ノードの target（＝ラベル）を、対応ブロックの id アンカーへ解決するために使う。
 * ドメイン非依存: 解決の材料はブロックの labels/id のみで、特定分野の知識を持たない。
 */
const LabelIndexContext = createContext<LabelIndex>({})

export const LabelIndexProvider = LabelIndexContext.Provider

/**
 * ラベルを id アンカーへ解決する関数を返す。
 * 未定義ラベル（未解決 ref）は undefined を返し、呼び出し側が描画時に検出できるようにする。
 */
export const useResolveLabel = (): ((target: string) => string | undefined) => {
  const index = useContext(LabelIndexContext)
  return (target: string): string | undefined => index[target]
}
