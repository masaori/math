# SageMath Check: matrix_sum_with_itself_zero_implies_zero

## 対象

**対象ラベル**: `matrix_sum_with_itself_zero_implies_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_sum_with_itself_zero_implies_zero`（自分自身との和が零行列なら零行列）
- 範囲: 準備の `2_ℂ = (2,0) ≠ 0_ℂ` の鎖、証明の `(i,k)` 成分の十一行の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の四行と `2_ℂ ≠ 0_ℂ` | `check_component_chain.sage` | `definition_of_cc` の実数の組で各行を組み、隣り合う項が等しく、`(2,0) ≠ (0,0)` | **PASS** | `QQ` で厳密 |
| 成分の鎖の十一行 | 同上 | 仮定 `X + X = O` を使う行以外を不定元の `X` で確かめる。仮定の行は、不定元の `X` では等号を外れ（否定コントロール）、仮定を満たす `X = O` を代入すると成り立つ | **PASS** | 9 通りの大きさで 360 段、否定コントロール 36 行 |
| 主張そのもの | 同上 | `X + X` の成分が生成するイデアルに全ての不定元が入る（仮定の解は `X = O` だけ） | **PASS** | 9 通りの大きさ |

## 計算の帰属と範囲

複素数は `QQ(i)`（ガウス有理数体。`2_ℂ^{-1} = 1/2` を含む）に取り、`X` の成分（`m, p ∈ {1, 2, 3}`）をその上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の複素数を代入しても成り立つ。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。
添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_sum_with_itself_zero_implies_zero
```

実行ログは `sagemath/check/matrix_sum_with_itself_zero_implies_zero/logs/` に保存する（2026-11-02）。
