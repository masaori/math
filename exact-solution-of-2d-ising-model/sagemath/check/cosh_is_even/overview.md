# SageMath Check: cosh_is_even

## 対象

**対象ラベル**: `cosh_is_even` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosh_is_even`（cosh は偶関数。cosh(-x) = cosh x）
- 範囲: 鎖の四行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 cosh の定義を -x へ | `check_proof_lines.sage` | exp(x), exp(-x), exp(-(-x)) を QQ 上の独立な不定元 Ep, Em, Emm に置き、定義の関数から作った左辺と比べる | **PASS** | 成り立つ |
| 2 行目 -(-x) = x | `check_proof_lines.sage` | QQ[x] の等号と、形式冪級数で exp(-(-x)) = exp(x)。不定元のままでは 1 行目と一致せず、Emm を Ep に置き換えると一致する | **PASS** | 成り立つ |
| 3 行目 加法の交換律 | `check_proof_lines.sage` | exp の値（または cosh・sinh の値）を QQ 上の独立な不定元に置いて厳密に比べる。不定元で成り立つ有理式の等号は、実数の値を代入しても成り立つ | **PASS** | 成り立つ |
| 4 行目 cosh の定義 | `check_proof_lines.sage` | exp の値（または cosh・sinh の値）を QQ 上の独立な不定元に置いて厳密に比べる。不定元で成り立つ有理式の等号は、実数の値を代入しても成り立つ。対照として sinh では一致しない | **PASS** | 成り立つ |
| 主張そのもの | `check_statement_at_points.sage` | QQ[x]（または QQ[x,y]）の形式冪級数として全次数 14 以下で比べる。本文の exp は 1 行 1 列の行列の exp の成分で部分和の極限なので、部分和の切り捨てで比べる。あわせて 6 点で具体の点で、本文の exp の部分和に尾の評価を半径として足したボール（RealBallField(512)）で比べる。許容誤差は置かず、ボールの重なり・上端と下端の比較で判定する。対照として x ≠ 0 の sinh(-x) と sinh(x) は重ならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosh_is_even
```

実行ログは `logs/` に保存する。
