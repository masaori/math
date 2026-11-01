# SageMath Check: cosh_sinh_product

## 対象

**対象ラベル**: `cosh_sinh_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `calc_formulae_000_cosh_sinh_product`（cosh・sinh の掛け算。`cosh(a)sinh(b) = (sinh(a+b) - sinh(a-b))/2`、`cosh(a)cosh(b) = (cosh(a+b) + cosh(a-b))/2`）
- 範囲: 二つの等式の鎖の九行ずつと、主張そのもの

## 証明の行との対応

二つの鎖は同じ形なので、行ごとに一つの検算が両方を扱う（`g = sinh` のとき符号 `-`、`g = cosh` のとき `+`）。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `cosh(a)g(b) = (exp(a)+exp(-a))/2 · (exp(b)±exp(-b))/2`（定義） | `check_lines_without_exp_properties.sage` | exp の 8 つの値を `QQ` 上の独立な不定元に置き、左辺を定義の関数から、右辺を本文の式のまま作って比べる | **PASS** | 厳密等号 |
| 2 行目 分数の積 | `check_lines_without_exp_properties.sage` | 同じ不定元で | **PASS** | 厳密等号 |
| 3 行目 分配則（4 つの積） | `check_lines_without_exp_properties.sage` | 同じ不定元で | **PASS** | 厳密等号 |
| 4 行目 `exp(s)exp(t) = exp(s+t)` を 4 箇所へ（`scalar_exp_product`） | `check_exp_product_line.sage` | `a, b` を `QQ[a,b]` の不定元に置き、本文の部分和で作った exp の形式冪級数を全次数 14 以下で比べる。4 つの組 `(a,b),(a,-b),(-a,b),(-a,-b)` で一致。対照として、3 行目と 5 行目が独立な不定元では一致しない（この行が exp の性質を使う唯一の行であること）、`exp(a)exp(-b) ≠ exp(a+b)` | **PASS** | 厳密等号、対照は不一致 |
| 5 行目 指数の整理 `a+(-b)=a-b`、`(-a)+b=-(a-b)`、`(-a)+(-b)=-(a+b)` | `check_lines_without_exp_properties.sage` | `QQ[a,b]` の多項式環の等号として（四則の恒等式の確認） | **PASS** | 厳密等号 |
| 6 行目 項の並べ替えとくくり | `check_lines_without_exp_properties.sage` | exp の 8 つの値の独立な不定元で | **PASS** | 厳密等号 |
| 7 行目 `1/4 = (1/2)(1/2)` | `check_lines_without_exp_properties.sage` | 同じ不定元で | **PASS** | 厳密等号 |
| 8 行目 分配則（`1/2` を括弧の中の二項へ） | `check_lines_without_exp_properties.sage` | 同じ不定元で | **PASS** | 厳密等号 |
| 9 行目 sinh（cosh）の定義を 2 箇所へ | `check_lines_without_exp_properties.sage` | 同じ不定元で、右辺を定義の関数から作る | **PASS** | 厳密等号 |
| 鎖の両端（左辺と最後の行） | `check_exp_product_line.sage` | 左辺と右辺を、それぞれ定義と形式冪級数から別々に作り、全次数 14 以下で比べる。対照として、符号を取り違えた `(sinh(a+b)+sinh(a-b))/2` は左辺と一致しない | **PASS** | 厳密等号、対照は不一致 |
| 主張そのもの | `check_statement_with_balls.sage` | 6 点の `(a,b) ∈ QQ^2`（`(0,0)`、`(10,-9)`、`(-20,-20)` などを含む）で、本文の exp を囲むボールから両辺を作って重なること、半径が相対 `2^{-150}` 未満であること。対照として、符号を取り違えた式は `a ≠ b` の 4 点で重ならない | **PASS** | 全点で成り立つ |

## 計算の帰属と範囲

- **厳密**: 係数は `QQ`。exp の性質を使わない行は、exp の値を独立な不定元に置くので、どの性質も使っていないことまで確かめている。
  exp の積の法則の行は、行列の exp が極限なので形式冪級数として全次数 14 以下の部分で比べた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 主張そのものの点での確認だけ。exp の値が `QQ` に収まらないためである。
  ボールは本文の exp から作った（共通の準備 `sagemath/_shared/one_by_one_matrix.sage` の `body_real_exp_ball`）。
  許容誤差は置かず、ボールの重なり（区間の共通部分が空でないこと）で判定する。

範囲外のもの:

- 選んだ以外の点と、14 次を超える項。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosh_sinh_product
```

実行ログは `logs/` に保存する。
