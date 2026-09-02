# 経路反転と接触対の対応

**対象ラベル**: `claim_path_reversal_contact_pair_preservation`
- 検証コード: `check.sage`
- 方法: 一辺 $L=2$ の全非後退置換について、経路反転 $\mathcal T(\varphi)$ を構成し、$\Psi_{\varphi}(\{\vec e,\vec f\})=\{\iota(\varphi(\vec e)),\iota(\varphi(\vec f))\}$ が接触対集合 $\operatorname{Ct}(\varphi)$ から $\operatorname{Ct}(\mathcal T(\varphi))$ への全単射であること、$\Psi_{\mathcal T(\varphi)}\circ\Psi_{\varphi}$ が恒等写像であること、接触対の個数が保存されること、各接触対の切り替え可能性が保存されることを全数検査する。
- 浮動小数点: 使用しない。
- 実行日: 2026-09-02
- 結果: 一辺 $L=2$ の非後退置換 $30{,}784$ 個・接触対 $470{,}336$ 件の全数で、全単射・恒等合成・個数保存・切り替え可能性の保存（切り替え可能 $192{,}896$ 件）が成り立った。
- 状態: PASS（2026-09-02 実行。実行 2 分 0 秒）。
