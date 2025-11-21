package Servlet;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Product;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
     
      ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        
        // 1. Lấy danh sách danh mục (giữ nguyên)
        List<Category> categoryList = categoryDAO.getAllCategories();
        
        // --- BẮT ĐẦU LOGIC PHÂN TRANG ---
        final int PRODUCTS_PER_PAGE = 12; // Đổi về 12 (hoặc 16 tùy bạn)
        int totalProducts = 0;
        int totalPages = 0;
        int currentPage = 1;

        // 2. Lấy tham số
        String categoryId = request.getParameter("cid");
        String searchQuery = request.getParameter("search");
        String pageParam = request.getParameter("page");
        
        // 3. Lấy trang hiện tại từ URL
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu nhập bậy, về trang 1
            }
        }
        
        List<Product> productList;
        
        // 4. Xử lý logic để lấy TỔNG sản phẩm và DANH SÁCH sản phẩm
        if (categoryId != null) {
            // Trường hợp: LỌC THEO DANH MỤC
            totalProducts = productDAO.getTotalProductCountByCid(categoryId);
            totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages; // Sửa lỗi logic
            if (currentPage < 1) currentPage = 1;
            
            int offset = (currentPage - 1) * PRODUCTS_PER_PAGE;
            productList = productDAO.getProductsByCategoryId(categoryId, offset, PRODUCTS_PER_PAGE);
            
        } else if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Trường hợp: TÌM KIẾM
            totalProducts = productDAO.getTotalProductCountBySearch(searchQuery);
            totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages; // Sửa lỗi logic
            if (currentPage < 1) currentPage = 1;
            
            int offset = (currentPage - 1) * PRODUCTS_PER_PAGE;
            productList = productDAO.searchProductsByName(searchQuery, offset, PRODUCTS_PER_PAGE);
            
        } else {
            // Trường hợp: TẤT CẢ SẢN PHẨM (Mặc định)
            
            // C1. Lấy "Tất cả sản phẩm" (phân trang)
            totalProducts = productDAO.getTotalProductCount();
            totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages; // Sửa lỗi logic
            if (currentPage < 1) currentPage = 1;
            
            int offset = (currentPage - 1) * PRODUCTS_PER_PAGE;
            productList = productDAO.getProductsWithPagination(offset, PRODUCTS_PER_PAGE);
            
            // [PHẦN MỚI] Lấy 7 sản phẩm bán chạy nhất
            List<Product> bestSellers = productDAO.getTopBestSellingProducts(7);
            
            if (bestSellers != null && !bestSellers.isEmpty()) {
                // Lấy Top 1
                request.setAttribute("top1BestSeller", bestSellers.get(0));
                
                // Lấy Top 2-7
                if (bestSellers.size() > 1) {
                    request.setAttribute("top2to7BestSellers", bestSellers.subList(1, Math.min(7, bestSellers.size())));
                }
            }
            // [HẾT PHẦN MỚI]
        }
        // --- KẾT THÚC LOGIC PHÂN TRANG ---

        
        // 5. Đặt các thuộc tính vào request
        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
        
        // Gửi thông tin lọc
        request.setAttribute("activeCategoryId", categoryId); 
        request.setAttribute("searchQuery", searchQuery); // Gửi lại từ khóa tìm kiếm
        
        // Gửi thông tin phân trang
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        // 6. Chuyển đến trang home.jsp
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}