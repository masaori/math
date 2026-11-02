# SageMath Check: negation_factors_out_of_right_factor

## 対象

**対象ラベル**: `negation_factors_out_of_right_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_negation_factors_out_of_right_factor`（右の因子の符号反転は行列の積の外へ出る）
- 範囲: 主張 `A(-B) = -(AB)` と、証明の `(i,k)` 成分の十行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の十行 | `check_component_chain.sage` | 鎖の項を各行に書かれた式どおりに組み、隣り合う項が等しい | **PASS** | 27 通りの大きさ、全成分で厳密等号 |
| 主張そのもの | 同上 | 本文の成分の式で組んだ左辺を、Sage 組み込みの演算（独立な経路）で組んだ右辺と比べる。否定コントロールとして、鎖の一項を落とした式とは一致しないことも確かめる | **PASS** | 27 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A, B` の成分（`m, n, p ∈ {1, 2, 3}`）を `QQ` 上の多項式環の不定元に置いた。
不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

鎖の項は多項式環の元なので、各行の根拠（`ℂ` の積の結合律・交換律・分配律）の適用は Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字・和の範囲・括弧・符号）が前の行と同じ値を持つことである。
符号反転は `multiply_by_minus_one` のとおり `(-1)·z`、行列の符号反転と差は共通の準備
`_shared/matrix_negation_and_difference_by_definition.sage` で本文の定義どおり成分から組んだ。
定義の行はその組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。
これを補うため、主張は Sage 組み込みの演算とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh negation_factors_out_of_right_factor
```

実行ログは `sagemath/check/negation_factors_out_of_right_factor/logs/` に保存する（2026-11-02）。
