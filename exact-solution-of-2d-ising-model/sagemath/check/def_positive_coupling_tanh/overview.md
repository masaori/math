# SageMath Check: def_positive_coupling_tanh

## 対象

**対象ラベル**: `def_positive_coupling_tanh`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_000g_definition_positive_coupling_tanh`（正の結合定数上の双曲線正接 0 < tanh K < 1）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| cosh K > sinh K > 0（cosh_sinh_basic_properties (3)） | `check_proof_lines.sage` | `QQ(E)` で差 `cosh K - sinh K = 1/E`、`K = log q` の 6 点で `QQ`、`K ∈ QQ` の 7 点でボール | **PASS** | 成り立つ |
| cosh K > 0 ⇒ cosh K ≠ 0 | `check_proof_lines.sage` | 同じ点で、0 を含まないこと | **PASS** | 成り立つ |
| sinh K, cosh K ∈ ℝ と商 ∈ ℝ | `check_proof_lines.sage` | 値が `QQ` または実数のボールとして作れること（所属の推論で計算は含まない） | **PASS** | 成り立つ |
| tanh K = sinh K/cosh K > 0 | `check_proof_lines.sage` | `QQ(E)` で `tanh = (E²-1)/(E²+1)`、点で正 | **PASS** | 成り立つ |
| tanh K < cosh K/cosh K = 1 | `check_proof_lines.sage` | `QQ(E)` で `1 - tanh = 2/(E²+1) = (cosh - sinh)/cosh`、点で `sinh/cosh < cosh/cosh`。`cosh/cosh = 1` は体の中で恒等的に真なので、定義の書き写しだけを見る（構成上一致する比較） | **PASS** | 成り立つ |
| 主張 0 < tanh K < 1 | `check_proof_lines.sage` | 同じ点で | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ(E)`（`E` は `exp(K)` の値の不定元、`exp(-K) = 1/E`）で確かめた。`K = log q`（`q ∈ QQ`、`q > 1`）の点では、本文 `def_real_logarithm_positive` の `exp(log y) = y` により `exp(K) = q` なので、`sinh K`・`cosh K`・`tanh K` が `QQ` に入り、大小も `QQ` で判定した。
- **`ℝ` への脱出（`RealBallField(512)`）**: `K ∈ QQ` の点の `exp(K)` は `QQ` に収まらないので、本文の exp の部分和に尾の評価を半径として足したボール（`sagemath/_shared/hyperbolic_by_definition.sage`）で比べた。Arb の exp は使わない。許容誤差は置かず、ボールの上端・下端の比較だけで判定する。

範囲外のもの: 選んだ以外の点。集合への所属だけを述べる推論の行（`ℝ_{>0} ⊂ ℝ`、閉性、等しい対象による置換）は、計算を含まないので、値が実数のボール（または `QQ`）として作れたことを見るだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_positive_coupling_tanh
```

実行ログは `logs/` に保存する。共通の準備は `sagemath/_shared/positive_coupling_and_real_log.sage`。
