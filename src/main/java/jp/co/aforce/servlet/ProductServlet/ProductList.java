package jp.co.aforce.servlet.ProductServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Comparator;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.dao.ProductDAO;

//このServletは、クエリパラメータsearchやcategoryに基づきProductDAOを使って商品リストを取得し、JSPへ転送するロジック。デフォルトは全件表示


@WebServlet("/views/product/ProductList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//商品一覧は参照処理であり、パラメータはURL経由で渡すため、doPostではなくdoGetを使うのがHTTP的にもUX的にも適切。
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//Query Parameter 「category」を取得
		String category = request.getParameter("category");
                //Query Parameter 「search」を取得
                String search = request.getParameter("search");
                //Query Parameter 「sort」を取得
                String sort = request.getParameter("sort");
		
                ProductDAO dao = new ProductDAO();
                //商品一覧格納用リスト定義　初期値null
                List<ProductBean> productList = null;
                boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))
                                || "true".equals(request.getParameter("ajax"));
		
		try {
			//検索キーワードが指定された場合
			if (search != null && !search.trim().isEmpty()) {
				//キーワード検索実行
				productList = dao.searchProducts(search);
				
				//カテゴリが指定された場合			
			}else if (category != null && !category.trim().isEmpty()) {
				//カテゴリ別検索実行
				productList = dao.getProductsByCategory(category);
				
				//両方指定されていない場合
			} else {
				//全商品取得
                                productList = dao.getAllProducts();
                        }
                        // SQLエラー発生時にServlet例外として投げる
                } catch (SQLException e) {
                        throw new ServletException(e);
                }

                if (productList != null) {
                        if (sort != null) {
                                switch (sort) {
                                case "price":
                                        productList.sort(Comparator.comparingDouble(ProductBean::getPrice));
                                        break;
                                case "name":
                                        productList.sort(Comparator.comparing(ProductBean::getProduct_name));
                                        break;
                                case "category":
                                        productList.sort(Comparator.comparing(ProductBean::getCategory_id));
                                        break;
                                default:
                                        productList.sort(Comparator.comparingInt(ProductBean::getProduct_id));
                                }
                        } else {
                                // デフォルトは商品ID順
                                productList.sort(Comparator.comparingInt(ProductBean::getProduct_id));
                        }
                }
		
                if (isAjax) {
                        response.setContentType("application/json; charset=UTF-8");
                        StringBuilder json = new StringBuilder();
                        json.append("[");
                        for (int i = 0; i < productList.size(); i++) {
                                ProductBean p = productList.get(i);
                                json.append("{")
                                    .append("\"product_id\":").append(p.getProduct_id()).append(",")
                                    .append("\"product_name\":\"").append(escapeJson(p.getProduct_name())).append("\",")
                                    .append("\"price\":").append(p.getPrice()).append(",")
                                    .append("\"image_url\":\"").append(escapeJson(p.getImage_url())).append("\"")
                                    .append("}");
                                if (i < productList.size() - 1) json.append(",");
                        }
                        json.append("]");
                        response.getWriter().write(json.toString());
                } else {
                        request.setAttribute("products", productList);
                        RequestDispatcher rd = request.getRequestDispatcher("/views/product/ProductList.jsp");
                        rd.forward(request, response);
                }
		
		
	}

        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

        }

        private String escapeJson(String s) {
                if (s == null) return "";
                return s.replace("\\", "\\\\").replace("\"", "\\\"");
        }

}
