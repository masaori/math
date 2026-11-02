# SageMath Check: cosh_half_angle_formula

## 対象

**対象ラベル**: `cosh_half_angle_formula` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosh_half_angle_formula`（cosh の半角公式。cosh x = 1 + 2 sinh²(x/2)）
- 範囲: 鎖の五行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 x = x/2 + x/2 | `check_proof_lines.sage` | QQ[x] の等号と形式冪級数 | **PASS** | 成り立つ |
| 2 行目 cosh_addition_formula の複号 + | `check_proof_lines.sage` | QQ[x]（または QQ[x,y]）の形式冪級数として全次数 14 以下で比べる。本文の exp は 1 行 1 列の行列の exp の成分で部分和の極限なので、部分和の切り捨てで比べる | **PASS** | 成り立つ |
| 3・5 行目 二乗の記法、同類項 | `check_proof_lines.sage` | cosh(x/2), sinh(x/2) を不定元 C, S に置いて | **PASS** | 成り立つ |
| 4 行目 cosh_sinh_basic_properties (2) を移項 | `check_proof_lines.sage` | 独立な不定元では成り立たず、剰余環 QQ[C,S]/(C²-S²-1) で成り立つ（この行が (2) だけを使う）。形式冪級数でも成り立つ | **PASS** | 成り立つ |
| 主張そのもの | `check_statement_at_points.sage` | QQ[x]（または QQ[x,y]）の形式冪級数として全次数 14 以下で比べる。本文の exp は 1 行 1 列の行列の exp の成分で部分和の極限なので、部分和の切り捨てで比べる。対照として半角を取らない式は一致しない。あわせて 6 点で具体の点で、本文の exp の部分和に尾の評価を半径として足したボール（RealBallField(512)）で比べる。許容誤差は置かず、ボールの重なり・上端と下端の比較で判定する | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosh_half_angle_formula
```

実行ログは `logs/` に保存する。
