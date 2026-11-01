# SageMath Check: scalar_multiple_by_one

## 対象

**対象ラベル**: `scalar_multiple_by_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_scalar_multiple_by_one`（1 倍しても行列は変わらない）
- 範囲: 主張 `1A = A` と、証明の `(i,j)` 成分の二行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(1A)_{ij}` の鎖の二行 | `check_component_chain.sage` | 三つの項を各行に書かれた式どおりに組み、隣り合う項が等しい | **PASS** | 9 通りの大きさ、全成分で厳密等号 |
| 主張そのもの | 同上 | 本文の成分の式で組んだ `1A` が `A` に等しく、Sage のスカラー倍 `1*A`（独立な経路）とも一致する | **PASS** | 9 通りの大きさで厳密等号 |

## 計算の帰属と範囲

`A` の成分を `QQ` 上の多項式環の不定元に置いた。大きさは `m, n ∈ {1, 2, 3}` の 9 通りである。
不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の大きさは検算の範囲外で、人手証明が担う。

鎖の項は多項式環の元なので、各行の根拠（`1` が `ℂ` の積の単位元であること）の適用は Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字・和の範囲・括弧）が前の行と同じ値を持つことである。
とくに「スカラー倍の定義」の行（第一行）は、共通の準備 `_shared/matrix_operations_by_definition.sage` の
組み方と同じ式なので構成上かならず一致し、検出できるのは本文の式の写し間違いだけである。これを補うため、主張は
Sage 組み込みの演算（独立な経路）とも比べた。添字は Sage の 0 始まりで、本文から 1 を引いたものに当たる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh scalar_multiple_by_one
```

実行ログは `sagemath/check/scalar_multiple_by_one/logs/` に保存する。
