package model;

public class GoodsVO {
	private String gid;
	private String title;
	private int price;
	private String brand;
	private String image;
	private String regDate;
	private String category3;
	private String link;
	private String mallName;
	
	
	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getMallName() {
		return mallName;
	}
	public void setMallName(String mallName) {
		this.mallName = mallName;
	}
	public String getCategory3() {
		return category3;
	}
	public void setCategory3(String category3) {
		this.category3 = category3;
	}
	@Override
	public String toString() {
		return "GoodsVO [gid=" + gid + ", title=" + title + ", price=" + price + ", brand=" + brand + ", image=" + image
				+ ", regDate=" + regDate + ", category3=" + category3 + ", link=" + link + ", mallName=" + mallName
				+ "]";
	}
	
	
	
}
