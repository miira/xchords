package cz.versarius.xchords;

/**
 * Named chord set/bag.
 * 
 * @author miira
 *
 */
public class ChordLibrary extends ChordBag implements Comparable {
	private String desc;
	private String name;
	private String path;
	private boolean changed;
	
	public ChordLibrary() {
	}
	
	public ChordLibrary(String name) {
		this.name = name;
	}
	
	public ChordLibrary(ChordBag bag) {
		super(bag);
	}
	
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getName() {
		return name;
	}
	public String getNameWithMark() {
		return (changed ? name + " *": name);
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}

	public boolean isChanged() {
		return changed;
	}

	public void setChanged(boolean changed) {
		this.changed = changed;
	}

	@Override
	public int compareTo(Object obj) {
		if (obj == null) return 0;
		if (!(obj instanceof ChordLibrary)) {
			return 0;
		}
		ChordLibrary other = (ChordLibrary)obj;
		if (other.name == null) {
			return -1;
		}
		return name.compareTo(other.name);
	}
}
