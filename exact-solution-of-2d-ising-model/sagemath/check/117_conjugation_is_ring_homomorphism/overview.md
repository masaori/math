# SageMath Check: 117_conjugation_is_ring_homomorphism

## 対象

**対象ラベル**: `conjugation_is_ring_homomorphism` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`

- 範囲: `mat_conj` の T_B(A) = (BA)B^{-1} の乗法性・単位性・合成則（check 01 は主張の数値確認と <mat_conj> の線型性、check 02 は証明の鎖を一行ずつ）

check 01 の B は exp で作って正則性を保証している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_ring_hom.sage` | 乗法性・単位性・線型性・合成則 T_A∘T_B = T_{AB} | 240 | 1.859e-12 | **PASS** |
| 02 | `check_02_chains.sage` | 証明の鎖を一行ずつ: 乗法性の 9 行、単位性の 3 行、合成則の準備の右逆元・左逆元・`(GH)^{-1} = H^{-1}G^{-1}` の各 5 行、合成則の 8 行。各行に書かれた式どおりに項を組み、隣り合う項が等しい（`T_B` は `mat_conj` の `(BA)B^{-1}`） | `n = 1, 2, 3` で各 4 例 | 厳密等号 | **PASS** |

check 02 は `A`・`C`・`X` の成分を `QQ` 上の多項式環の不定元に置き、正則な `B` と合成則の `G`・`H` は行列式 ±1 の整数行列を取って逆行列を `QQ` 上で厳密に求めた。積と単位行列は `_shared/matrix_operations_by_definition.sage` で本文の定義どおり成分から組み、`(GH)^{-1}` は Sage 組み込みの `inverse` で求めて鎖の左端に置いた。浮動小数点と `RR` / `CC` への脱出はない。正則な行列は具体的な有限個だけを試しており、一般の正則行列は人手証明が担う。

check 01 の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<mat_conj>（T_B が線型）はこの check に含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 117
```

実行ログは `sagemath/check/117_conjugation_is_ring_homomorphism/logs/` に保存してある（この表の数値はそのログから取った）。
