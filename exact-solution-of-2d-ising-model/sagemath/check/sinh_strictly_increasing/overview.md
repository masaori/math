# SageMath Check: sinh_strictly_increasing

## 対象

**対象ラベル**: `sinh_strictly_increasing` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sinh_strictly_increasing`（sinh は狭義単調増加）
- 範囲: 準備の鎖、差の鎖の四行と分子の正値性の含意、帰結、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 x<y ⇒ exp(x)<exp(y)、x<y ⇒ -y<-x ⇒ exp(-y)<exp(-x) | `check_proof_lines.sage` | x<y の 7 組（差が 10^{-9} の組と -74 < -73 を含む）で、-y<-x は QQ で、exp の大小は具体の点で、本文の exp の部分和に尾の評価を半径として足したボール（RealBallField(512)）で比べる。許容誤差は置かず、ボールの重なり・上端と下端の比較で判定する | **PASS** | 成り立つ |
| 差の鎖の 1〜3 行目（定義、分母の等しい分数の差、分子の並べ替え） | `check_proof_lines.sage` | exp の値（または cosh・sinh の値）を QQ 上の独立な不定元に置いて厳密に比べる。不定元で成り立つ有理式の等号は、実数の値を代入しても成り立つ | **PASS** | 成り立つ |
| 差の鎖の 4 行目 > 0、分子の正値性の三つの含意、帰結 sinh x < sinh y | `check_proof_lines.sage` | 同じ 7 組で具体の点で、本文の exp の部分和に尾の評価を半径として足したボール（RealBallField(512)）で比べる。許容誤差は置かず、ボールの重なり・上端と下端の比較で判定する | **PASS** | 成り立つ |
| 主張そのもの | `check_statement_at_points.sage` | 格子点 k/4（k = -40,…,40）で隣どうしの sinh のボールが狭義に増える。対照として cosh では増えない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sinh_strictly_increasing
```

実行ログは `logs/` に保存する。
