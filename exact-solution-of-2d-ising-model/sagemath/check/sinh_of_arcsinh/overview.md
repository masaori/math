# SageMath Check: sinh_of_arcsinh

## 対象

**対象ラベル**: `sinh_of_arcsinh` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sinh_of_arcsinh`（sinh(arcsinh(y)) = y）
- 範囲: 準備、exp(u) の鎖、exp(-u) の鎖の七行、主の鎖の五行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 (y+s)(s-y) = 1 | `check_proof_lines.sage` | 関数体 QQ(y)[s]/(s²-y²-1) で | **PASS** | 成り立つ |
| exp(u) の鎖 exp(log(y+s)) = y+s | `check_proof_lines.sage` | y の 7 点で、u のボールに本文の exp の部分和をボール演算で施して y+s と重なる | **PASS** | 成り立つ |
| exp(-u) の鎖の 1〜4 行目 | `check_proof_lines.sage` | L[W]（W は exp(-u) の値の不定元）で厳密に | **PASS** | 成り立つ |
| exp(-u) の鎖の 5〜7 行目（exp の積の法則、exp(0) = 1） | `check_proof_lines.sage` | W·exp(u) = 1 の下でだけ s-y になること（対照として不定元のままでは s-y でない）を L で、7 点で exp(-u)exp(u) と exp(-u) = s-y をボールで | **PASS** | 成り立つ |
| 主の鎖の 3〜5 行目と主張 | `check_proof_lines.sage` | L で (y+s-(s-y))/2 = y、7 点で sinh(arcsinh(y)) のボールが y と重なる | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sinh_of_arcsinh
```

実行ログは `logs/` に保存する。
