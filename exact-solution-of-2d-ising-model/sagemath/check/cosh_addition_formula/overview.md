# SageMath Check: cosh_addition_formula

## 対象

**対象ラベル**: `cosh_addition_formula` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_001_claim_cosh_addition_formula`（cosh の加法定理。cosh(x±y) = cosh x cosh y ± sinh x sinh y）
- 範囲: 複号 + の鎖の八行、複号 - の鎖の四行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| + の 1・4〜8 行目（定義、分母と分子に 2、足して引く、分配則、分数の和と積、定義を 4 箇所へ） | `check_proof_lines.sage` | exp の値（または cosh・sinh の値）を QQ 上の独立な不定元に置いて厳密に比べる。不定元で成り立つ有理式の等号は、実数の値を代入しても成り立つ（exp(x), exp(-x), exp(y), exp(-y), exp(x+y), exp(-(x+y)) の 6 個） | **PASS** | 成り立つ |
| + の 2 行目 -(x+y) = (-x)+(-y) | `check_proof_lines.sage` | QQ[x,y] の等号 | **PASS** | 成り立つ |
| + の 3 行目 exp の積の法則を 2 箇所へ（scalar_exp_product） | `check_proof_lines.sage` | QQ[x]（または QQ[x,y]）の形式冪級数として全次数 14 以下で比べる。本文の exp は 1 行 1 列の行列の exp の成分で部分和の極限なので、部分和の切り捨てで比べる。対照として、独立な不定元では 1 行目と 3 行目が一致しない（この行だけが exp の性質を使う） | **PASS** | 成り立つ |
| - の 1〜4 行目（x-y = x+(-y)、+ の場合を -y へ、偶奇性、四則）と + の鎖の両端 | `check_proof_lines.sage` | QQ[x]（または QQ[x,y]）の形式冪級数として全次数 14 以下で比べる。本文の exp は 1 行 1 列の行列の exp の成分で部分和の極限なので、部分和の切り捨てで比べる。対照として複号を取り違えると一致しない | **PASS** | 成り立つ |
| 主張そのもの | `check_statement_at_points.sage` | 6 点の両方の複号で具体の点で、本文の exp の部分和に尾の評価を半径として足したボール（RealBallField(512)）で比べる。許容誤差は置かず、ボールの重なり・上端と下端の比較で判定する。対照として複号を取り違えた式は x, y ≠ 0 の点で重ならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosh_addition_formula
```

実行ログは `logs/` に保存する。
